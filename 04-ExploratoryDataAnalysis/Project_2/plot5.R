library(ggplot2)

## load two data file
NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")

## subsetting data
mobile <- grep("vehicle", SRC$EI.Sector, value = TRUE, ignore.case = TRUE)
data_mobile <- subset(SRC, SRC$EI.Sector %in% mobile)
NEI_Baltimore <- NEI[which(NEI$fips == 24510), ]
data_mobile_final <- subset(NEI_Baltimore, NEI_Baltimore$SCC %in% data_mobile$SCC)
NEI_final <- aggregate(data_coal_final["Emissions"], list(year = data_coal_final$year), sum)

## draw plot
g <- ggplot(NEI_final, aes(year, Emissions))
g + geom_line(colour = "orange", size = 1) + geom_point() + labs(title = "Total Vehicle Emissions in Baltimore City")

## save graph
dev.copy(png, file = "plot5.png", height = 480, width = 480)
dev.off()