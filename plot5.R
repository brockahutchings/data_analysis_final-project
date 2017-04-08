########### Instructions ##################
#How have emissions from motor vehicle sources changed from 1999–2008
#in Baltimore City?
##########################################

#Import the file as NEI and SCC
NEI <- readRDS("data/summarySCC_PM25.rds")

#limit years
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))

##SCC
SCC <- readRDS("data/Source_Classification_Code.rds")

# Baltimore City fips
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate
MD.df <- aggregate(MD.onroad[, 'Emissions'], by = list(MD.onroad$year), sum)

colnames(MD.df) <- c('year', 'Emissions')

#set file name
png('plot5.png')

#generate plot
ggplot(data = MD.df, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year), stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))

#remember to turn dev off
dev.off()