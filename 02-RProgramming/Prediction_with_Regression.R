##------------------------Prediction with Regression----------------------------
## Pro: easy to implement
## Cons: often poor performance in nonlinear settings

library(caret)
data(faithful)
set.seed(333)
inTrain <- createDataPartition(y = faithful$waiting, p = 0.5, list = FALSE)
trainFaith <- faithful[inTrain, ]
testFaith <- faithful[-inTrain, ]
head(trainFaith)

plot(trainFaith$waiting, trainFaith$eruptions, pch = 19, col = "blue", xlab = "Waiting", ylab = "Duration")

lm1 <- lm(eruptions ~ waiting, data = trainFaith)
summary(lm1)

lines(trainFaith$waiting, lm1$fitted, lwd = 3)      ## add regression line

newdata <- data.frame(waiting = 80)                 ## add a new value
predict(lm1, newdata)                               ## predict a new value

## plot predictions - training and test

par(mfrow = c(1, 2))
plot(trainFaith$waiting, trainFaith$eruptions, pch = 19, col = "blue", xlab = "Waiting", ylab = "Duration")
lines(trainFaith$waiting, predict(lm1), lwd = 3)
plot(testFaith$waiting, testFaith$eruptions, pch = 19, col = "blue", xlab = "Waiting", ylab = "Duration")
lines(testFaith$waiting, predict(lm1, newdata = testFaith), lwd = 3)

## get training set / test set errors

sqrt(sum((lm1$fitted - trainFaith$eruptions)^2))       ## calculate RMSE on training
sqrt(sum((predict(lm1, newdata = testFaith) - testFaith$eruptions)^2))     ## calculate RMSE on test

## prediction intervals

pred1 <- predict(lm1, newdata = testFaith, interval = "prediction")
ord <- order(testFaith$waiting)                  ## sorting testFaith$waiting
plot(testFaith$waiting, testFaith$eruptions, pch = 19, col = "blue")
matlines(testFaith$waiting[ord], pred1[ord, ], type = "l", col = c(1, 2, 2), lty = c(1, 1, 1), lwd = 3)

## same process with caret

modFit <- train(eruptions ~ waiting, data = trainFaith, method = "lm")
summary(modFit$finalModel)
