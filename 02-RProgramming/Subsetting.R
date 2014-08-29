##---------------------Subsetting---------------------------
## [] always returns an object of the same class as the original
## [[]] is used to extract elements of a list or a data frame
## $ is used to extract elements of a list or data frame by name, similar to [[]]

x <- c("a", "b", "c", "d", "a")
x[1]

x[x>"a"]                             ## b c d

u <- x>"a"
u

x[u]                                 ## same as line 9

##--------------------Subsetting a Matrix-------------------

x <- matrix(1:6, 2, 3)
x[1,2]
x[1,2, drop = FALSE]

x[1, ]
x[1, , drop = FALSE]

##-------------------Subsetting a List---------------------

x <- list(foo = 1:4, bar = 0.6)

x[1]                                 ## with $foo
x[[1]]                               ## without $foo
x$bar

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x[c(1, 3)]                           ## only foo and baz

name <- "foo"
x[[name]]                            ## OK with that
x$name                               ## NOT OK
x$foo

x <- list(a = list(10,12,14), b = c(3.14, 2.81))
x[[c(1, 3)]]
x[[1], [3]]
x[[c(2,1)]]

##--------------------Removing NA Values-------------------

x <- c(1,2,NA,4,NA,5)
bad <- is.na(x)
x[!bad]

## If there are multiple things 

x <- c(1,2,NA,4,NA,5)
y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x,y)
good
x[good]
y[good]

airquality[1:6, ]
good <- complete.cases(airquality)
airquality[good, ][1:6, ]