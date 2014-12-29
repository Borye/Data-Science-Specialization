##------------------------------------caret---------------------------------
## SPAM Example

library(lattice)
library(ggplot2)
library(caret)
library(kernlab)
data(spam)

## data spliting
inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)  ## p is the percent of training set
training <- spam[inTrain, ]
testing <- spam[-inTrain, ]
dim(training)

## fit a model
set.seed(32343)
modelFit <- train(type ~ ., data = training, method = "glm")
modelFit
modelFit$finalModel

## prediction
predictions <- predict(modelFit, newdata = testing)
predictions

## confusion matrix
confusionMatrix(predictions, testing$type)