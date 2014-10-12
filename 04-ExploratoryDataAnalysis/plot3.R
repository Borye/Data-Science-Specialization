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

plot(data$Datetime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(data$Datetime, data$Sub_metering_1, col = "black")
lines(data$Datetime, data$Sub_metering_2, col = "red")
lines(data$Datetime, data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.7, lty=c(1, 1), col = c("black", "red", "blue"))


## save graph
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()