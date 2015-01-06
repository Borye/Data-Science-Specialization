library(caret)
library(ggplot2)
library(rpart)
library(randomForest)
library(gbm)
library(plyr)
library(base)

setwd("./R")
train = read.csv("pml-training.csv", na.string = c("NA", ""))
test = read.csv("pml-testing.csv", na.string = c("NA", ""))
dim(train);dim(test)

##-------------------------------preprocessing-------------------------------------------

## transfer all the factor variables to numeric variables

for(i in 7 : dim(train)[2] - 1){
    if(class(train[, i]) != "numeric"){
        train[, i] <- as.numeric(as.character(train[, i]))
    }
}

str(train)

for(i in 7 : dim(test)[2] - 1){
    if(class(test[, i]) != "numeric"){
        test[, i] <- as.numeric(as.character(test[, i]))
    }
}

str(test)

## deal with NAs

num_na <- 0

for(i in 1 : dim(train)[2]){
    if(sum(is.na(train[, i])) != 0){
         num_na <- c(num_na, i)
    }
}

num_na <- num_na[-1]
train <- train[, -num_na]
str(train)

num_na <- 0

for(i in 1 : dim(test)[2]){
    if(sum(is.na(test[, i])) != 0){
        num_na <- c(num_na, i)
    }
}

num_na <- num_na[-1]
test <- test[, -num_na]
str(test)

##--------------------------------feature selection---------------------------------------------

## featurePlot(x = train[, c("X", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp", "new_window", "num_window")], y = train$classe, plot = "pairs")

## Because the x and cvtd_timestamp has too much relation, so delete them

## checking for if there are any zero covariates

#!!!!!!!!!!! nearZeroVar(training, saveMetrics = TRUE)

## correlation

train <- train[, -c(1, 2, 3, 4, 5, 6)]

#M <- abs(cor(train[, -c(1, 2, 3, 57)]))      
#diag(M) <- 0                        
#which(M > 0.8, arr.ind = T)

## PCA

#preProc <- preProcess(train[, -c(1, 2, 3, 57)], method = "pca", pcaComp = 50)
#train_PCA <- predict(preProc, train[, -c(1, 2, 3, 57)])
#train_PCA$classe <- train$classe

## cross validation

folds <- createFolds(y = train$classe, k = 10, list = TRUE, returnTrain = TRUE)  ## k is the number of folds, list = TRUE means return list
sapply(folds, length)

training <- list(train[folds[[1]], ])     ## use list 
testing <- list(train[-folds[[1]], ])

for(i in 1 : 10){training[[i]] <- train[folds[[i]], ]}
for(i in 1 : 10){testing[[i]] <- train[-folds[[i]], ]}


##--------------------------------learning---------------------------------------------- 

## Use tree learning

modFit_rpart <- rpart(classe ~ ., method = "class", data = training[[1]])
modFit_rpart

pred_rpart <- predict(modFit_rpart, testing[[1]], type = "class")
confusionMatrix(testing[[1]]$classe, pred_rpart)

## check the correlation between different variables

cor(training01$magnet_arm_x, training01$magnet_arm_y)

qplot(1:dim(training[[1]])[1], raw_timestamp_part_1, colour = classe, data = training01)
qplot(1:dim(training[[1]])[1], raw_timestamp_part_2, colour = classe, data = training01)

## those two qplot shows that raw_timestamp are correlated to classe. So try to training

## use tree with two times variable 
modFit <- train(classe ~ raw_timestamp_part_1 + raw_timestamp_part_2, method = "rpart", data = training)
print(modFit$finalModel)

pred <- predict(modFit, testing)
confusionMatrix(testing$classe, pred)

## use random forest

modFit_rf <- randomForest(classe ~ ., data = training[[1]], mtry = 30, importance = TRUE)
modFit_rf

pred_rf <- predict(modFit_rf, testing[[1]])
confusionMatrix(testing[[1]]$classe, pred_rf)

varImpPlot(modFit_rf)

## use boosting

modFit_gbm <- gbm(classe ~ ., data = training[[1]], distribution = "multinomial", n.trees = 2000, shrinkage = 0.01, interaction.depth = 4, verbose = TRUE)
summary(modFit_gbm)
gbm.perf(modFit_gbm)
pretty.gbm.tree(modFit_gbm, 1)

pred_gbm <- predict(modFit_gbm, testing[[1]], n.trees = gbm.perf(modFit_gbm, plot.it = FALSE), type = "response")
pred_gbm_value <- rep(NA, dim(testing[[1]])[1])
for(i in 1 : dim(pred_gbm)[1]){
    pred_gbm_value[i] <- LETTERS[as.numeric(which.max(pred_gbm[, , 1][i, ]))]
}
confusionMatrix(testing[[1]]$classe, pred_gbm_value)

## out-of-sample error

error_rpart <- rep(NA, 10)
error_rf <- rep(NA, 10)

## for rpart

for(i in 1 : 10){
    modFit_rpart <- rpart(classe ~ ., method = "class", data = training[[i]])
    pred_rpart <- predict(modFit_rpart, testing[[i]], type = "class")
    error_rpart[i] <- 1 - confusionMatrix(testing[[i]]$classe, pred_rpart)$overall[1]
}

OsamError_rpart <- mean(error_rpart^2)

## for rf

for(i in 1 : 10){
    modFit_rf <- randomForest(classe ~ ., data = training[[1]], mtry = 30, importance = FALSE)
    pred_rf <- predict(modFit_rf, testing[[i]], type = "class")
    error_rf[i] <- 1 - confusionMatrix(testing[[i]]$classe, pred_rf)$overall[1]
}

OsamError_rf <- mean(error_rf^2)
print(OsamError_rf)

## test test-set

confusionMatrix(predict(modFit_rpart, test, type = "class"), a)



pred_gbm_test <- predict(modFit_gbm, test, n.trees = gbm.perf(modFit_gbm, plot.it = FALSE), type = "response")
pred_gbm_value_test <- rep(NA, dim(test)[1])
for(i in 1 : dim(pred_gbm_test)[1]){
    pred_gbm_value_test[i] <- LETTERS[as.numeric(which.max(pred_gbm_test[, , 1][i, ]))]
}
confusionMatrix(pred_gbm_value_test, a)

table(pred_gbm_value_test, a)
