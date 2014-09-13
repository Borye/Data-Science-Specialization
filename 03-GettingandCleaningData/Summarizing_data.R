##--------------------------Summarizing data------------------------------
## getting data from web

fileurl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileurl, destfile="./data/restaurants.csv", method="auto")
restData <- read.csv("./data/restaurants.csv")

##--------------------------look at a bit of the data----------------------

head(restData, n=3)                ## head of the data, default is 6 rows
tail(restData, n=3)

##--------------------------make summary-----------------------------------

summary(restData)   

##--------------------------Depth information------------------------------

str(restData)

##--------------------------Quantiles of quantitative variables------------

quantile(restData$councilDistrict, na.rm=TRUE)
quantile(restData$councilDistrict, probs=c(0.5, 0.75, 0.9))          ## change the probability

##--------------------------make table------------------------------------

table(restData$zipCode, useNA="ifany")                     ## if there are NA value there will be it
table(restData$councilDistrict, restData$zipCode)          ## two dimensional table

##--------------------------check for missing values-----------------------

sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

##--------------------------Row and column sums----------------------------

colSums(is.na(restData))
all(colSums(is.na(restData)==0))

##--------------------------values with specific characteristics-------------

table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))           ## it can be used to check two characters

restData[restData$zipCode %in% c("21212", "21213"), ]      ## make a table that just contain zipcode 21212 and 21213

##--------------------------Cross tabs--------------------------------------

data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data=DF)                ## make cross table
xt

##--------------------------Size of a data set------------------------------

fakeData = rnorm(1e5)
object.size(fakeData)

print(object.size(fakeData), units="Mb")