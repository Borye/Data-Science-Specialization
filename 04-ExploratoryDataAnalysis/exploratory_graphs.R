##--------------------------------exploratory graphs------------------------------
## why we want to do that
## to understand data properties, to find patterns in data, to suggest modeling strategies, to debug analyses
## download data

pollution <- read.csv("./avgpm25.csv", colClasses = c("numeric", "character", "factor", "numeric", "numeric"))
head(pollution)

summary(pollution$pm25)

##-------------------------------boxplot function---------------------------------

boxplot(pollution$pm25, col = "blue")

boxplot(pollution$pm25, col = "blue")
abline(h = 12)

##-------------------------------hist graph--------------------------------------

hist(pollution$pm25, col = "green")      ## show more detail
rug(pollution$pm25)

hist(pollution$pm25, col = "green", breaks = 100)      ## add more bars
rug(pollution$pm25)

hist(pollution$pm25, col = "green")      ## add some line on it
abline(v = 12, lwd = 2)                  ## add a line at 12
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)       ## add a line on the median

##-------------------------------bar plot----------------------------------------

barplot(table(pollution$region), col = "wheat", main = "Number of counties in Each Region")

##-------------------------------multiple boxplots-------------------------------

boxplot(pm25 ~ region, data = pollution, col = "red")

##-------------------------------multiple histograms-----------------------------

par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")

##-------------------------------scatter plot------------------------------------

with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)

with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)

par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))          ## par function is used to specify global graphics parameters
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))
