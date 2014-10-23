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

par(mfrow = c(2, 2), mar = c(4, 4, 2, 2))  

plot(data$Datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(data$Datetime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(data$Datetime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(data$Datetime, data$Sub_metering_1, col = "black")
lines(data$Datetime, data$Sub_metering_2, col = "red")
lines(data$Datetime, data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.7, bty = "n", xjust = 1, lty=c(1, 1), col = c("black", "red", "blue"))

plot(data$Datetime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

## save graph
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()