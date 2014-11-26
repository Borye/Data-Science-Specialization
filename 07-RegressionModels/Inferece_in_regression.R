##-------------------------------Inference in regression------------------------

library(UsingR); data(diamond)
y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y ~ x)
summary(fit)$coefficients       

## getting the confidence interval

sumcoef <- summary(fit)$coefficients
sumcoef[1, 1] + c(-1, 1) * qt(0.975, df = fit$df) * sumcoef[1, 2]
sumcoef[2, 1] + c(-1, 1) * qt(0.975, df = fit$df) * sumcoef[2, 2]    ## with 95% confidence, we estimate that a 0.1 carat increase in diamond size results in a 355.6 tp 388.6 increase in price in dollars

## plot the confidence interval

xVals <- seq(min(x), max(x), by = .01)
yVals <- fit$coef[1] + fit$coef[2] * xVals
newdata <- data.frame(x = xVals)
p1 <- predict(fit, newdata, interval = ("confidence"))
p2 <- predict(fit, newdata, interval = ("prediction"))
plot(x, y, frame = FALSE, xlab = "Carat", ylab = "Dollars", pch = 21, col = "black", bg = "lightblue", cex = 2)
abline(fit, lwd = 2)
lines(xVals, p1[, 2]); lines(xVals, p1[, 3])
lines(xVals, p2[, 2]); lines(xVals, p2[, 3])

