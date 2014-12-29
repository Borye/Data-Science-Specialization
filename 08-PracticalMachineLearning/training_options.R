##------------------------------training options-------------------------------------
library(lattice)
library(ggplot2)
library(caret)
library(kernlab)
data(spam)
inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)  ## p is the percent of training set
training <- spam[inTrain, ]
testing <- spam[-inTrain, ]
modelFit <- train(type ~ .,data = training, method = "glm")

args(train.default)    ## check the training options
args(trainControl)