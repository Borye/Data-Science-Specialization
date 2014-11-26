##-------------------------Count outcomes poisson GLMs---------------------------
## poisson distribution is mainly about count, time and rate

par(mfrow = c(1, 3))
plot(0 : 10, dpois(0 : 10, lambda = 2), type = "h", frame = FALSE)
plot(0 : 20, dpois(0 : 20, lambda = 10), type = "h", frame = FALSE)
plot(0 : 200, dpois(0 : 200, lambda = 100), type = "h", frame = FALSE)

## Website data

load("./gaData.rda")
gaData$julian <- julian(gaData$date)      ## convert to julian date
head(gaData)

plot(gaData$julian, gaData$visits, pch = 19, col = "darkgrey", xlab = "Julian", ylab = "Visits")

## linear regression line

lm1 <- lm(gaData$visits ~ gaData$julian)
abline(lm1, col = "red", lwd = 3)

## posisson regression in R

glm1 <- glm(gaData$visits ~ gaData$julian, family = "poisson")
lines(gaData$julian, glm1$fitted, col = "blue", lwd = 3)

## mean-variance relationship

plot(glm1$fitted, glm1$residuals, pch = 19, col = "grey", xlab = "Fitted", ylab = "Residuals")

## Fitting rates in R

glm2 <- glm(gaData$simplystats ~ gaData$julian, offset = log(gaData$visits + 1), family = "poisson") ## must use log, +1 is because 0 wiill make problems
plot(gaData$julian, glm2$fitted, col = "blue", pch = 19, xlab = "Date", ylab = "Fitted Counts")
points(gaData$julian, glm1$fitted, col = "red", pch = 19)

plot(gaData$julian, gaData$simplystats / (gaData$visits + 1), col = "grey", xlab = "Date", 
     ylab = "Fitted Rates", pch = 19)
lines(gaData$julian, glm2$fitted / (gaData$visits + 1), col = "blue", lwd = 3)