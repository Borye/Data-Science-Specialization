##-------------------------data.table----------------------------
## Inherets from data.frame

DT = data.table(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))

head(DT, 3)              ## show first 3 rows

tables()                 ## see all the data tables in memory

## subsetting rows

DT[2, ]                  

DT[DT$y == "a", ]        ## select all y="a"

DT[c(2, 3)]          

## Calculating values for variables with expressions

DT[, list(mean(x), sum(z))]

## Adding new columns

DT[, w:=z^2]

## Multiple operations
## adding a colnum m, m = log2((x+z)+5)

DT[, m:= {tmp <- (x+z); log2(tmp + 5)}]

## plyr like operations

DT[, a:=x>0]

DT[, b:= mean(x+w), by=a]      ## adding a colnum b, calculate mean of x+w when a = TRUE AND  all the rows when a = false

## Keys

DT <- data.table(x = rep(c("a", "b", "c"), each=100), y=rnorm(300))
setkey(DT, x)
DT['a']