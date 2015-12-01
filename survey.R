## survey project in R

# install and load library
install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(ggplot2)

# download a file
download.file("http://files.figshare.com/2236372/combined.csv",  "data/portal_data_joined.csv")

# import file
surveys <- read.csv('data/portal_data_joined.csv')

# data parsing for Figure 1
surveys_comparison <- surveys %>%
  select(month, taxa) %>%
  group_by(month) %>%
  tally

# building Figure 1
ggplot(data = surveys, aes(x=month)) + geom_bar()
ggplot(data = surveys_comparison, aes(x=month, y=n, group = 1)) + geom_line(colour = "red", linetype = "dashed", size = 1.5 ) + geom_point(size = 5) + xlab("Month") + ylab("Total Captured") + ggtitle("Monthly Capture Rates")

# Exporting figure 1
pdf("Figure1.pdf")
ggplot(data = surveys_comparison, aes(x=month, y=n, group = 1)) + geom_line(colour = "red", linetype = "dashed", size = 1.5 ) + geom_point(size = 5) + xlab("Month") + ylab("Total Captured") + ggtitle("Monthly Capture Rates")
dev.off()

# data parsing Figure 2
surveys_relationship <- surveys %>%
  filter(hindfoot_length > 0, weight > 0) %>%
  select(hindfoot_length, weight, genus)

# creating Figure 2
ggplot(data = surveys_relationship, aes(x=hindfoot_length, y = weight, color = genus)) + geom_point() + xlab("Hindfoot Length (mm)") + ylab("Weight (g)") + ggtitle("Correlation of foot length and weight") + theme(legend.title=element_blank(),panel.grid.minor=element_blank(), panel.grid.major=element_blank())

# saving Figure 2
pdf("Figure 2.pdf")
ggplot(data = surveys_relationship, aes(x=hindfoot_length, y = weight, color = genus)) + geom_point() + xlab("Hindfoot Length (mm)") + ylab("Weight (g)") + ggtitle("Correlation of foot length and weight") + theme(legend.title=element_blank(),panel.grid.minor=element_blank(), panel.grid.major=element_blank())
dev.off()

# data parsing for Figure 3
surveys_distribution <- surveys %>%
  filter(year == 1997) %>%
  filter(weight < 60)

# creating Figure 3
ggplot(data = surveys_distribution, aes(x = surveys_distribution$weight)) + geom_histogram(binwidth = 1.5) + xlab("Weight (g)") + ylab("Count") + ggtitle("Weight distribution of specimens in 1997")

# saving Figure 3
pdf("Figure 3.pdf")
ggplot(data = surveys_distribution, aes(x = surveys_distribution$weight)) + geom_histogram(binwidth = 1.5) + xlab("Weight (g)") + ylab("Count") + ggtitle("Weight distribution of specimens in 1997")
dev.off()

## Stastical test: ANOVA

# filtering out all years except 1995 and 1996
surveys_stat <- surveys %>%
  filter(year > 1994) %>%
  filter(year < 1997)

# creating a file with only weight from 1995 and no NA's  
surveys_stat_1995 <- surveys_stat %>%
  filter(year == 1995) %>%
  select(weight) %>%
  filter(!is.na(weight))

# renaming column as "b"
names(surveys_stat_1995)[names(surveys_stat_1995)=="weight"] <- "b"

# creating a file with only weight from 1996 and no NA's
surveys_stat_1996 <- surveys_stat %>%
  filter(year == 1996) %>%
  select(weight) %>%
  filter(!is.na(weight))

# renaming column as "a"
names(surveys_stat_1996)[names(surveys_stat_1996)=="weight"] <- "a"

# merging the two files with weight data from individual years
weight_1995_1996 <- merge(surveys_stat_1995, surveys_stat_1996)

# command for running the ANOVA and a brief summary of the results 
# recieve a p=1 allowing one to conclude that there is not statistical differences between the weights in 1995 and 1996
anova <- aov(b ~ a, data = weight_1995_1996)
summary(anova)

# citations 
citation(package = "dplyr", lib.loc = NULL)
citation(package = "ggplot2", lib.loc = NULL)

