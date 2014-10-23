library(ggplot2)

## load two data file
NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")

## subsetting data
coal <- grep("Coal", SRC$EI.Sector, value = TRUE)
data_coal <- subset(SRC, SRC$EI.Sector %in% coal)
data_coal_final <- subset(NEI, NEI$SCC %in% data_coal$SCC)
NEI_final <- aggregate(data_coal_final["Emissions"], list(year = data_coal_final$year), sum)

## draw plot
g <- ggplot(NEI_final, aes(year, Emissions))
g + geom_line(colour = "green", size = 1) + geom_point() + labs(title = "Total Emissions from Coal Related Sources in US")

## save graph
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()