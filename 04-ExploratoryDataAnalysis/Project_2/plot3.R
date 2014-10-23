library(ggplot2)

## load two data file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset data by choose the fips == 24510
NEI_Baltimore <- NEI[which(NEI$fips == 24510), ]
NEI_final <- aggregate(NEI_Baltimore["Emissions"], list(type = NEI_Baltimore$type, year = NEI_Baltimore$year), sum)

## plot using ggplot2
g <- ggplot(NEI_final, aes(year, Emissions, colour = type))
g + geom_line() + geom_point() + labs(title = "Total Emissions by Type in Baltimore City")

## save graph
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
