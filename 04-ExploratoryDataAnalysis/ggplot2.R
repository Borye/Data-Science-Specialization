##-------------------------------ggplot2------------------------------------

install.packages("ggplot2")
library(ggplot2)
str(mpg)

qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = drv)    ## seperate by different drv
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))   ## adding a line 
qplot(hwy, data = mpg, fill -drv)           ## plot a histograms plot

##------------------------------Take several plots--------------------------

qplot(displ, hwy, data = mpg, facets = .~drv)
qplot(hwy, data = mpg, facets = drv~., binwidth = 2)

##-------------------------------qqplot2 system---------------------------
## basically make a plot layers by layers

load("maacs.Rda")

qplot(pm25, eno, data = maacs, facets = .~mopos, geom = c("point", "smooth"), method = "lm")

g <- ggplot(maacs, aes(pm25, eno))
summary

p <- g + geom_point()             
print(p)

g + geom_point()              ## this line will make the plot

g + geom_point() + geom_smooth()
 
g + geom_point() + geom_smooth(method = "lm")     ## add a regreesion line

g + geom_point() + facet_grid(. ~ mopos) + geom_smooth(method = "lm")

##-------------------------------change color--------------------------------

g + geom_point(color = "steelblue", size = 4, alpha = 1/2)

g + geom_point(aes(color = mopos), size = 4, alpha = 1/2)    ## make two colors

##--------------------------------modify labels-----------------------------

g + geom_point(aes(color = mopos)) + labs(title = "MAACS Cohort") + labs(x = expression("log" * PM[2.6]), y = "Nocturnal Symptoms")

##--------------------------------customizing the smooth-----------------------

g + geom_point(aes(color = mopos), size = 2, alpha = 1/2) + geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)    ## Make the line bigger

##--------------------------------changing the theme---------------------------

g + geom_point(aes(color = mopos)) + theme_bw(base_family = "Times")

##--------------------------------A notes about axis limits---------------------

testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50, 2] <- 100                                 ## outlier
plot(testdat$x, testdat$y, type = "l", ylim = c(-3, 3))

g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line()

g + geom_line + ylim(-3, 3)             ## WRONG!!!! BECAUSE IT WILL REMOVE THE OULIER!!!!

g + geom_line() + coord_cartesian(ylim = c(-3, 3))

##-------------------------------make split tertiles-------------------------------

## calculate the deciles of the data
cutpoints <- quantile(maacs$duBedMusM, seq(0, 1, length = 4), na.rm = TRUE)

## cut the data at the deciles and create a new factor variable
maacs$duBedMusM_new <- cut(maacs$duBedMusM, cutpoints)

## see the levels of the newly created factor variable
levels(maacs$duBedMusM_new)

## setup ggplot with data frame
g <- ggplot(maacs, aes(pm25, eno))

## add layers
g + geom_point(alpha = 1/3) + facet_wrap(mopos ~ duBedMusM_new, nrow = 2, ncol = 4) + geom_smooth(method = "lm", se = FALSE, col = "steelblue") + theme_bw(base_family = "Avenir", base_size = 10) + labs(x = expression("log"*PM[2.5])) + labs(y = "Nocturnal Symptoms") + labs(title = "MAACS Cohort")
##    add points                 make panels                                              add smoother                                                  change theme                                        add labels 

