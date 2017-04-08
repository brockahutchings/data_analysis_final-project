############# Instrutions ###############
#Compare emissions from motor vehicle sources in Baltimore City with
#emissions from motor vehicle sources in Los Angeles County, California
#(fips == "06037"). Which city has seen greater changes over time in motor
#vehicle emissions?
#########################################

#Import NEI
NEI <- readRDS("data/summarySCC_PM25.rds")

#limit the years of NEI
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))

#Import SCC
SCC <- readRDS("data/Source_Classification_Code.rds")

#calculate flips for both cities
MD.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')

CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregate
MD.DF <- aggregate(MD.onroad[, 'Emissions'], by = list(MD.onroad$year), sum)

#set col names
colnames(MD.DF) <- c('year', 'Emissions')

MD.DF$City <- paste(rep('MD', 4))

CA.DF <- aggregate(CA.onroad[, 'Emissions'], by = list(CA.onroad$year), sum)

#set col names
colnames(CA.DF) <- c('year', 'Emissions')

CA.DF$City <- paste(rep('CA', 4))

#create dataframe
DF <- as.data.frame(rbind(MD.DF, CA.DF))

#name plot
png('plot6.png')

#generate plot
ggplot(data = DF, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year),stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + facet_grid(. ~ City) + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))

#remember to turn dev off
dev.off()