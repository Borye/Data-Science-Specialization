##----------------------Loop Function---------------------
## for, while loops is useful when programming but not particularly easy when
## working interactively on the command line. 

##----------------------lapply---------------------------
## Loop over a list and evaluate a function on each element
## always return a list

x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)           

x <- 1:4
lapply(x, runif)

## if there are no function, we can use a anonymous function and apply lapply
## extract first column of two matrices

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
lapply(x, function(elt) elt[, 1])

##---------------------sapply-----------------------------
## sapply will try to simplify the result of lapply 
## for example, if the result is a list where every element is length 1, then a vector is returned

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)              ## this function is return a list 

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
sapply(x, mean)              ## this function is return a vector

##--------------------apply-------------------------------
## it is most often used to apply a function to the rows or columns of a matrix
## it can be used with general arrays

x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)                      ## return the mean of each of the columns of the matrix
apply(x, 1, sum)                       ## return the sum of each of the rows of the matrix

a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
apply(a, c(1, 2), mean)

##--------------------tapply-----------------------------
## it is used to apply a function over subsets of a vector

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
tapply(x, f, mean)                     ## pass the factor variable f in the mean function, that allows
                                       ## to take the mean of each group of numbers in x