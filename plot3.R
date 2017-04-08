######## Instructions ################
#Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, which of these four sources
#have seen decreases in emissions from 1999–2008 for Baltimore City?
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 
#plotting system to make a plot answer this question.
######################################

#Import the files as NEI and SCC
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")