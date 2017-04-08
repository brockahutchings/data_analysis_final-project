#######Instructions################
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.
###################################

#Import the files as NEI and SCC
NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

#get Sample data
NEIsample <- NEI[sample(nrow(NEI), size = 1000, replace = F), ]

#set aggrigates
Emissions <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)

#round emmisions
Emissions$PM <- round(Emissions[, 2] / 1000, 2)

#print plot 1
png(filename = "plot1.png")
barplot(Emissions$PM, names.arg = Emissions$Group.1, main = expression('Total Emission of PM'[2.5]), xlab = 'Year', ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))

#turn dev off
dev.off()

