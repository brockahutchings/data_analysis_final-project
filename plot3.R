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

#get sample data
NEIsample <- NEI[sample(nrow(NEI), size = 5000, replace = F), ]

#get subset of fips
MD <- subset(NEI, fips == 24510)

#limit years
MD$year <- factor(MD$year, levels = c('1999', '2002', '2005', '2008'))

#setting for output
png('plot3.png', width = 800, height = 500, units = 'px')

#generate plot
ggplot(data = MD, aes(x = year, y = log(Emissions))) +
  facet_grid(. ~ type) + guides(fill = F) +
  geom_boxplot(aes(fill = type)) + stat_boxplot(geom = 'errorbar') +
  ylab(expression(paste('Log', ' of PM'[2.5],
                        ' Emissions'))) + xlab('Year') +
                        ggtitle('Baltimore City, Maryland Emissions per Type ')+
                        geom_jitter(alpha = 0.10)

#remember to turn dev off
dev.off()