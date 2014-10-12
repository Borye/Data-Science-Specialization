##-----------------------------------Structure of a data analysis-------------------------
## Steps in a data analysis

# Define the question
# Define the ideal data set
# Determine what data you can access
# Obtain the data
# Clean the data
# Exploratory data analysis
# Statistical prediction/modeling
# Interpret results
# Challenge results
# Synthesize/write up results
# create reproducibal code

## our cleaned data set for this example: 

install.packages("kernlab")
library(kernlab)
data(spam)
str(spam[, 1:5])

## the question is can I automatically detect emails that are SPAM or not
## can I use quantitative characteristics of the emails to classify them as SPAM/HAM

# Perform the subsampling

set.seed(3435)
trainIndicator = rbinom(4601, size = 1, prob = 0.5)
table(trainIndicator)

trainSpam = spam[trainIndicator == 1, ]
testSpam = spam[trainIndicator == 0, ]

## exploratory data analysis look at the summarie of the data, check for missing data, create exploratory plots....

names(trainSpam)                                     ## look at the column name of the data
head(trainSpam)
table(trainSpam$type)

plot(trainSpam$capitalAve ~ trainSpam$type)
plot(log10(trainSpam$capitalAve + 1) ~ trainSpam$type)
plot(log10(trainSpam[, 1:4] + 1))                      ## relationships between predictors
hCluster = hclust(dist(t(trainSpam[, 1:57])))          ## clustering
plot(hCluster)
hClusterUpdated = hclust(dist(t(log10(trainSpam[, 1:55] + 1))))
plot(hClusterUpdated)

## Statistical prediction/modeling. Should be informed by the results of your exploratory analysis

trainSpam$numType = as.numeric(trainSpam$type) - 1
costFunction = function(x, y) sum(x != (y > 0.5))
cvError = rep(NA, 55)
library(boot)
for (i in 1:55) {
    lmFormula = reformulate(names(trainSpam)[i], response = "numType")
    glmFit = glm(lmFormula, family = "binomial", data = trainSpam)
    cvError[i] = cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]    
}

## which predictor has minimum cross-validated error?

## Interpret results, use the appropriate language, give an explanation, interpret coefficients, interpret measure sof uncertainty

## Chanllenge results

# question
# Data source
# processing
# analysis
# conclusions

## chalenge measures of uncertainty
## challenge choices of terms to include in models
## think of potential alternative analyses

## synthesize/write up results. Lead with the question, summarize the anlyses into the story, don't include every analysis include it if it is needed for the story
## order analyses according to the story, rather than chronologically, include pretty figures that contribute to the story

