##---------------creating vectors------------------
## use c() function

x <- c(0.5,0.6)       ## numeric type
x <- c(TRUE FALSE)    ## logical type
x <- c("a", "b", "c") ## character type
x <- 9:29             ## integer

## use vetor() function
x <- vector("numeric", length = 10)
x

##----------------Explicit Coercion---------------
## make the object have some class
## as. function

x <- 0:6
class(x)              ## integer

as.numeric(x)         ## numeric
as.logical(x)         ## logical
as.character(x)       ## character

##----------------Create Matrices-----------------

m <- matrix(nrow = 2, ncol = 3)      ## 2x3 matrix full of NA

m <- matrix(1:6, nrow = 2, ncol = 3) ## 1-6 natrix 2x3

m <- 1:10                            ## 1-10 matrix 2x5
dim(m) <- c(2,5)                     

## binding matrix using cbind() and rbind()
x <- 1:3
y <- 10:12
cbind(x,y)
rbind(x,y)

##----------------Lists----------------------------
## Lists is a special type of vector that can contain elements of different classes.

x <- list(1, "a", TRUE, 1 + 4i)
x

##----------------Factors--------------------------
## Represent categorical data

x <- factor(c("yes", "yes", "no", "yes", "no"))
x

table(x)                      ## can tell us the information about x

##----------------Missing Values-------------------
## Missing values are denoted by NA or NaN
#  is.na() is used to test objects if they are NA

x <- c(1,2,NA,10,3)
is.na(x)

##----------------Data Frames----------------------
## They are represented as a special type of list
## data frames can store different classes of objects in each column
## data frames have a special attribute called row.names
## data frames are usually created by calling read.table() or read.csv()
## Can be converted to a matrix by calling data.matrix()

x <- data.frame(foo = 1:4, bar = c(T,F,F,F))
x

## Names function
## objects can also have names, which is very useful for writing readable code and self-describing

x <- 1:3
names(x) <- c("foo", "bar", "norf")
x

## matrices also can have name

m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d"))
m