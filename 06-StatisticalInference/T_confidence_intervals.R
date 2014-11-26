##-----------------------------T confidence intervals-------------------------

## sleep data: In r typing data(sleep) brings up the sleep data, which shows the increase in hours for 10 
## patients on two soporific drugs. 

## paired t confidence interval, which only appeared at the two data is correlated.
data(sleep)
head(sleep)

g1 <- sleep$extra[1:10]
g2 <- sleep$extra[11:20]
difference <- g2 - g1
mn <- mean(difference)
s <- sd(difference)
n = 10

mn + c(-1, 1) * qt(0.975, n-1) * s / sqrt(n)
t.test(difference)
t.test(g2, g1, paired = TRUE)
t.test(extra ~ I(relevel(group, 2)), paired = TRUE, sleep)

## chickweight data in R

library(datasets); data(ChickWeight); library(reshape2)
## define weight gain or loss
wideCW <- dcast(ChickWeight, Diet + Chick ~ Time, value.var = "weight")     ## reshape the data as from a long format to a short wider format
names(wideCW)[-(1:2)] <- paste("time", names(wideCW)[-(1:2)], sep = "")
library(dplyr)
wideCW <- mutate(wideCW, gain = time21 - time0)

## do interval compare the 1 and 4 group
wideCW14 <- subset(wideCW, Diet %in% c(1, 4))
rbind(
    t.test(gain ~ diet, paired FALSE, var.equal = TRUE, data = wideCW14)$conf,
    t.test(gain ~ diet, paired FALSE, var.equal = FALSE, data = wideCW14)$conf
    )

t.test(gain ~ Diet, pared = FALSE, var.equal = TRUE, data = wideCW14)    ## Hypothesis Testing
