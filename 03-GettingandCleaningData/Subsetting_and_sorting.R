##----------------------------Subsetting and Sorting--------------------------
## create frame

set.seed(13435)
x <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
x <- x[sample(1:5), ]                 ## break the order
x$var2[c(1, 3)]=NA                    ## add NA in var2

## Using aggregate
## This function is subsetting the dataset1 using two columns "subject" and "activity" by calculate the mean of the rest of the data
dataset2 <- aggregate(dataset1, list(dataset1$Subject, dataset1$Activity), mean)

##----------------------------looking single column----------------------------

x[,1]                                 ## column 1
x[,"var1"]
x[1:2, "var2"]                        ## first and second row of column var2

##----------------------------logical calculation-----------------------------

x[(x$var1 <= 3 & x$var3 > 11), ]      ## var1 smaller or equal 3 and var3 larger than 11

##----------------------------dealing with NA---------------------------------

x[which(x$var2 > 8), ]                ## find numbers greater than 8, not return NA

##----------------------------sorting data-----------------------------------

sort(x$var1)
sort(x$var1, decreasing=TRUE)         ## decreasing sort
sort(x$var2, na.lat=TRUE)             ## make NA at last

##----------------------------ordering data---------------------------------

x[order(x$var1), ]                    ## ording at var1
x[order(x$var1, x$var3)]              ## var1 first and then var3

##----------------------------adding rows and columns-----------------------

x$var4 <- rnorm(5)                    ## add a column name var4
Y <- cbind(x, rnorm(5))               ## add a column name rnorm(5) 
 