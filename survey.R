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

#ideas for ways to graphically represent the survey data
#Composition: Within species, how does average, minimum, maximum, hooflength change over time represented by a stacked area chart
#Relationship: Look average weight per sex per species through a scatterplot or bubble chart
#Distribution: Within a genuses how does average, min, max weight change on a month my month basis using a stacked line histogram
#Example, explore distribution of weight for each species
#all will need a data parsing step
#followed by building a figure 

