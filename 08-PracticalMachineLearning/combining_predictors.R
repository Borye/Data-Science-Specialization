##------------------------------Combining predictors--------------------------
## Model stacking

library(ISLR)
data(Wage)
library(ggplot2)
library(caret)

## create a building data set and validation set

Wage <- subset(Wage, select = -logwage)
inBuild <- createDataPartition(y = Wage$wage, p = 0.7, list = FALSE)
validation <- Wage[-inBuild, ]
buildData <- Wage[inBuild, ]
inTrain <- createDataPartition(y = buildData$wage, p = 0.7, list = FALSE)
training <- buildData[inTrain, ]
testing <- buildData[-inTrain, ]

dim(training)
dim(testing)
dim(validation)

## build two different models

mod1 <- train(wage ~ ., method = "glm", data = training)
mod2 <- train(wage ~ ., method = "rf", data = training, trControl = trainControl(method = "cv"), number = 3)

## predict on the testing test

pred1 <- predict(mod1, testing)
pred2 <- predict(mod2, testing)
qplot(pred1, pred2, colour = wage, data = testing)

## fit a model that combines predictors

predDF <- data.frame(pred1, pred2, wage = testing$wage)
combModFit <- train(wage ~ ., method = "gam", data = predDF)
combPred <- predict(combModFit, predDF)

## testing errors

sqrt(sum((pred1 - testing$wage)^2))
sqrt(sum((pred2 - testing$wage)^2))
sqrt(sum((combPred - testing$wage)^2))      ## smallest

## predict on validation data set

pred1V <- predict(mod1, validation)
pred2V <- predict(mod2, validation)
predVDF <- data.frame(pred1 = pred1V, pred2 = pred2V)
combPredV <- predict(combModFit, predVDF)

## evaluate on validation

sqrt(sum((pred1V - validation$wage)^2))
sqrt(sum((pred2V - validation$wage)^2))
sqrt(sum((combPredV - validation$wage)^2))      ## smallest