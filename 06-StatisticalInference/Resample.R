##------------------------------Resample---------------------------------
## bootstrap principle
## Suppose that I have a statistic that estimates some population parameter, but I don't know its sampling distribution
## The bootstrap principle suggests uding the distribution defined by the data to approximate its sampling distribution

install.packages("UsingR")
library(UsingR)
data(father.son)
x <- father.son$sheight
n <- length(x)
B = 10000
resamples <- matrix(sample(x, n * B, replace = TRUE), B, n)
resampledMedians <- apply(resamples, 1, median)
hist(resampledMedians)


## Bootstrap procedure for bootstrap

## 1. Sample n observations with replacement from the observed data resulting in one simulated comlete dataset
## 2. Take the median of the simulated dataset
## 3. Repeat these two steps B times, resulting in B simulated medians
## 4. These medians are approximatedly drawn from the sampling distribution of the median of n observations, therefore we can
##     - Draw a histogram of them
##     - Calculate their standard deviation to estimate the standard error of the median
##     - Take the 2.5th and 97.5th percentiles as a confidence interval for the median

B <- 10000
resamples <- matrix(sample(x, n * B, replace = TRUE), B, n)
medians <- apply(resamples, 1, median)
sd(medians)
quantile(medians, c(0.025, 0.975))

g = ggplot(data.frame(medians = medians), aes(x = medians))
g = g + geom_histogram(color = "black", fill = "lightblue", binwidth = 0.05)
g

