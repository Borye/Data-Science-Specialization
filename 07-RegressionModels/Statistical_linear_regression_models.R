##----------------------------Statistical linear regression models-------------------------

library(UsingR)
data(diamond)
plot(diamond$carat, diamond$price,
     xlab = "Mass (carats)", 
     ylab = "Price (SIN $)", 
     bg = "lightblue", 
     col = "black", cex = 1.1, pch = 21, frame = FALSE)
abline(lm(price ~ carat, data = diamond), lwd = 2)      ## price is outcome, carat is predictor

fit <- lm(price ~ carat, data = diamond)
fit

## The answer gives me that we estimate an expected 3721.0(SIN $) dollar increase in the price for every carat increase in mass of diamond
## The intercept -259.6 is the expected price of a 0 carat diamond

fit2 <- lm(price ~ I(carat - mean(carat)), data = diamond)     ## shift the carat value by value of average of the carat value, to interpreted as the expected response at the average carat value
fit2

## Thus 500.1($) is the expected price for the average sized diamond of the data (0.2042carats)

fit3 <- lm(price ~ I(carat * 10), data = diamond)              ## multiply carat by 10
fit3

## we expect a 372.1 (SIN $) change in price for every 1/10th of a carat increase in mass of diamond

##------------------------------predicting the price of a diamond---------------------------------------

newx <- c(0.16, 0.27, 0.34)          ## these are the carat of diamond that I wish to predict the price

coef(fit)[1] + coef(fit)[2] * newx

predict(fit, newdata = data.frame(carat = newx))