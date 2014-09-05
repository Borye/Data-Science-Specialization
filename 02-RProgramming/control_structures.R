##-----------------------Control Structures----------------------------
## Control Structure in R allow you to control the flow of execution of the program
## depending on runtime condition

##-----------------------if/else--------------------------------------

if (x > 3) {
  y <- 10
} else {
  y <- 0
}

##-----------------------for-----------------------------------------

x <- c("a", "b", "c", "d")

for (i in 1:4) {
  print(x[i])
}

for (i in seq_along(x)) {
  print(x[i])
}

for (letter in x) {
  print(letter)
}

##----------------------while---------------------------------------

count <- 0
while(count < 10) {
  print(count)
  count <- count + 1
}

##----------------------repeat--------------------------------------
## repeat initiates an infinite loop. these are not commonly used in statistical applications but they
## do have their uses. The only way to exit a repeat loop is to call break

x0 <- 1
to1 <- 1e-8

repeat {
  x1 <- computeEstimate()
  
  if (abs(x1 - x0) < to1) {
    break
  } else {
    x0 <- x1
  }
}

##-----------------------next--------------------------------------

for(i in 1:100) {
  if(i <= 20) {
    ## skip the first 20 iterations
    next
  }
  ## Do something here
}