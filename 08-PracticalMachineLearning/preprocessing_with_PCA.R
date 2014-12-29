##------------------------------preprocessing with principal components analysis-----------------------
## correlated predictors
library(kernlab)
library(caret)
data(Wage)
inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)
training <- spam[inTrain, ]
testing <- spam[-inTrain, ]

M <- abs(cor(training[, -58]))      ## correlation matrix except "type"
diag(M) <- 0                        ## setting the correlation between variabls with itself equal to 0
which(M > 0.8, arr.ind = T)         ## find out which variable have the correlation larger then 0.8; arr.ind = T shows where the variable are in the matrix(row? col?)

names(spam[c(34, 32)])

plot(spam[, 34], spam[, 32])

## Use basic PCA idea: we should pick a weighted combination of the two correlated predictors to capture the most information possible
## Principal components in R - procomp

smallSpam <- spam[, c(34, 32)]
prComp <- prcomp(smallSpam)
plot(prComp$x[, 1], prComp$x[, 2])

prComp$rotation          ## this means add the two variables together is the best way, subtract them is the second best way

## PCA on SPAM data
typeColor <- ((spam$type == "spam") * 1 + 1)
prComp <- prcomp(log10(spam[, -58] + 1))
plot(prComp$x[, 1], prComp$x[, 2], col = typeColor, xlab = "PC1", ylab = "PC2")

## PCA with caret
preProc <- preProcess(log10(spam[, -58] + 1), method = "pca", pcaComp = 2)
spamPC <- predict(preProc, log10(spam[, -58] + 1))
plot(spamPC[, 1], spamPC[, 2], col = typeColor)

## preprocessing with PCA
preProc <- preProcess(log10(training[, -58] + 1))
trainPC <- predict(preProc, log10(training[, -58] + 1))
modelFit <- train(training$type ~ ., method = "glm", data = trainPC)

testPC <- predict(preProc, log10(testing[, -58] + 1))
confusionMatrix(testing$type, predict(modelFit, testPC))

## alternative
modelFit <- train(training$type ~ ., method = "glm", preProcess = "pca", data = training)
confusionMatrix(testing$type, predict(modelFit, testing))