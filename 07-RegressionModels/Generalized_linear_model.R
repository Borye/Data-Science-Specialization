##-------------------------------Generalized linear model------------------------------
## look at binary data

load("./ravensData.rda")
head(ravensData)

## fit linear regression in R

lmRavens <- lm(ravensData$ravenWinNum ~ ravensData$ravenScore)
summary(lmRavens)$coef

## fit logistic regression

logRegRavens <- glm(ravensData$ravenWinNum ~ ravensData$ravenScore, family = "binomial")
summary(logRegRavens)

## ravens fitted values

plot(ravensData$ravenScore, logRegRavens$fitted, pch = 19, col = "blue", xlab = "Score", ylab = "Prob Ravens Win")

## Odds ratios and confidence intervals

exp(logRegRavens$coeff)

exp(confint(logRegRavens))

## ANOVA for logistic regression

anova(logRegRavens, test = "Chisq")