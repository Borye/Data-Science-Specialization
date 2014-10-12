##-----------------------------base plotting system---------------------------
## contain graphic and grDevices package
## there are two phases to creating a base plot: initializing a new plot and annotating an existing plot

library(datasets)

hist(airquality$Ozone)       ## Draw a new plot

with(airquality, plot(Wind, Ozone))

airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

##----------------------------base plot with annotation-------------------------

library(datasets)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")    ## Add a title

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", type = "n"))     ## type = n means not plot anything just setup the basic stuff 
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))

##---------------------------base plot with regression line---------------------

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", pch = 20))       ## pch means the plotting symbol
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

##---------------------------multiple base plots---------------------------------

par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))  ## mfrow devide the plot in to one row three column, mar means the margin size, oma means the outer margin size
with(airquality, {
    plot(Wind, Ozone, main = "Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
    plot(Temp, Ozone, main = "Ozone and Temperature")
    mtext("Ozone and Weather in New York City", outer = TRUE)   ## main title
})

##----------------------------base plotting demonstration-------------------------

x <- rnorm(100)
hist(x)
y <- rnorm(100)
plot(x, y)
z <- rnorm(100)
plot(x, z)
par(mar = c(2, 2, 2, 2))
plot(x, y, pch = 19)
plot(x, y, pch = 10)
plot(x, y, pch = 2)
plot(x, y, pch = 4)

example(points)
pchShow()                  ## see which number for which symbol

plot(x, y, pch = 20)
title("Scatterplot")
text(-2, -2, "Label")
legend("topleft", legend = "Data", pch = 20)
fit <- lm(y ~ x)
abline(fit)
abline(fit, lwd = 3)
abline(fit, lwd = 3, col = "blue")
plot(x, y, xlab = "Weight", ylab = "Height", main = "Scatterplot", pch = 20)
fit <- lm(y ~ x)
abline(fit, lwd = 3, col = "red")
z <- rpois(100, 2)
par(mfrow = c(2, 1))
plot(x, y, pch = 20)
plot(x, z, pch = 19)
par(mar = c(2, 2, 1, 1))            ## make the plot bigger
plot(x, y, pch = 20)
plot(x, z, pch = 19)
par(mfrow = c(2, 2))                ## make 4 plots 
par(mar = c(4, 4, 2, 2))
plot(x, y)
plot(y, x)
plot(x, z)
plot(y, z)

par(mfrow = c(1, 1))
x <- rnorm(100)
y <- x + rnorm(100)
g <- gl(2, 50)
g <- gl(2, 50, labels = c("Male", "Female"))
str(g)
plot(x, y, type = "n")               ## plot with no data
points(x[g == "Male"], y[g == "Male"], col = "green")
points(x[g == "Female"], y[g == "Female"], col = "blue", pch = 19)