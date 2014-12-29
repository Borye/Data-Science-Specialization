##-------------------------------Boosting-----------------------------
## Basic idea: take lots of (possibly) weak predictors, Weight them and add them up, get a stronger predictor

library(ISLR)
data(Wage)
library(ggplot2)
library(caret)
Wage <- subset(Wage, select = -logwage)
inTrain <-  createDataPartition(y = Wage$wage, p = 0.7, list = FALSE)
training <- Wage[inTrain, ]
testing <- Wage[-inTrain, ]

modFit <- train(wage ~ ., method = "gbm", data = training, verbose = FALSE)
modFit

qplot(predict(modFit, testing), wage, data = testing)