##-------------------------------------Forecasting-----------------------------------
## get google stock data

library(quantmod)
from.dat <- as.Date("01/01/08", format = "%m/%d/%y")
to.dat <- as.Date("12/31/13", format = "%m/%d/%y")
getSymbols("GOOG", src = "google", from = from.dat, to = to.dat)

GOOG$GOOG.Volume <- 0                    ## must add this to make to.monthly work, don't know why yet
mGoog <- to.monthly(GOOG)
googOpen <- Op(mGoog)
ts1 <- ts(googOpen, frequency = 12)      ## create time series
plot(ts1, xlab = "Years + 1", ylab = "GOOG")

## decompose a time series into parts

plot(decompose(ts1), xlab = "Years + 1")

## training and test sets

ts1Train <- window(ts1, start = 1, end = 5)
ts1Test <- window(ts1, start = 5, end = (7 - 0.01))
ts1Train

## simple moving average

plot(ts1Train)
lines(ma(ts1Train, order = 3), col = "red")

## exponential smoothing

ets1 <- ets(ts1Train, model = "MMM")
fcast <- forecast(ets1)
plot(fcast)
lines(ts1Test, col = "red")
