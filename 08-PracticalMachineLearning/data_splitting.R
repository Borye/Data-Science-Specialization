##--------------------------------data splitting-----------------------------
library(lattice)
library(ggplot2)
library(caret)
library(kernlab)
data(spam)
inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)  ## p is the percent of training set
training <- spam[inTrain, ]
testing <- spam[-inTrain, ]
dim(training)


## k-fold
set.seed(32323)
folds <- createFolds(y = spam$type, k = 10, list = TRUE, returnTrain = TRUE)  ## k is the number of folds, list = TRUE means return list
sapply(folds, length)       ## check every folds length

folds[[1]][1:10]

## return test set
set.seed(32323)
folds <- createFolds(y = spam$type, k = 10, list = TRUE, returnTrain = FALSE)  ## k is the number of folds, list = TRUE means return list
sapply(folds, length)       ## check every folds length

## resampling
set.seed(32323)
folds <- createResample(y = spam$type, times = 10, list = TRUE)
sapply(folds, length)

## time slices
set.seed(32323)
time <- 1:1000
folds <- createTimeSlices(y = time, initialWindow = 20, horizon = 10)
names(folds)
folds$train[[1]]     ## 20 elements
folds$test[[1]]      ## 10 elements