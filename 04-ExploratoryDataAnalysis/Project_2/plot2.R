## load two data file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset data by choose the fips == 24510
NEI_Baltimore <- NEI[which(NEI$fips == 24510), ]

## subset data by year
Emissions_by_year_Baltimore <- aggregate(Emissions ~ year, NEI_Baltimore, sum)

## plot average PM2.5 emissions by year
plot(Emissions_by_year_Baltimore, type = "b", main = "Total PM2.5 Emissions in Baltimore by Year", xlab = "Year", 
     ylab = "Total PM2.5 Emissions in Baltimore", col = "red", lwd = 2)

## save graph
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()