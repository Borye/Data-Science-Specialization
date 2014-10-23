library(ggplot2)

## load two data file
NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")

## subsetting data
mobile <- grep("vehicle", SRC$EI.Sector, value = TRUE, ignore.case = TRUE)
data_mobile <- subset(SRC, SRC$EI.Sector %in% mobile)
NEI_Baltimore <- NEI[which(NEI$fips == 24510), ]
NEI_LA <- NEI[which(NEI$fips == "06037"), ]
data_mobile_final_Baltimore <- subset(NEI_Baltimore, NEI_Baltimore$SCC %in% data_mobile$SCC)
data_mobile_final_LA <- subset(NEI_LA, NEI_LA$SCC %in% data_mobile$SCC)
NEI_final_Baltimore <- aggregate(data_mobile_final_Baltimore["Emissions"], list(year = data_mobile_final_Baltimore$year), sum)
NEI_final_LA <- aggregate(data_mobile_final_LA["Emissions"], list(year = data_mobile_final_LA$year), sum)

NEI_final_LA$city <- rep("Los Angeles", 4)
NEI_final_Baltimore$city <- rep("Baltimore", 4)

merge_final <- merge(NEI_final_LA, NEI_final_Baltimore, by = c("year", "Emissions", "city"), all.x = TRUE, all.y = TRUE)


## draw plot
g <- ggplot(merge_final, aes(year, Emissions, colour = city))
g + geom_line() + geom_point() + labs(title = "Total Vehicle Emissions in Baltimore City and Los Angeles") 

## save graph
dev.copy(png, file = "plot6.png", height = 480, width = 480)
dev.off()