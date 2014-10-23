## load two data file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset data by year
Emissions_by_year <- aggregate(Emissions ~ year, NEI, sum)

## plot average PM2.5 emissions by year
plot(Emissions_by_year, type = "b", main = "Total PM2.5 Emissions by Year", xlab = "Year", 
     ylab = "Total PM2.5 Emissions", col = "blue", lwd = 2)

## save graph
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()