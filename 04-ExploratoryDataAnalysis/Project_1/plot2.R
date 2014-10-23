## Reading data

Data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.string = "?", stringsAsFactors=F)   
Data$Date = as.Date(Data$Date, format="%d/%m/%Y")        ## convert date to format 2000-01-01 

## subsetting data

data <- subset(Data, subset = (Data$Date >= "2007-02-01" & Data$Date <= "2007-02-02"))
rm(Data)                  ## remove Data

## Converting dates

datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## draw plot
plot(data$Datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## save graph
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()