## Question 1

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
download.file(fileurl, destfile="./data/Data.csv", method="auto")
Data <- read.csv("./data/Data.csv")
x <- Data$ACR == 3 & Data$AGS == 6

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg "
download.file(fileurl, destfile="./data/Jeff.jpg", method = "auto", mode="wb")
Data <- readJPEG("./data/Jeff.jpg", native=TRUE)
quantile(Data, probs=c(0.3, 0.8)) 


fileurl1="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
fileurl2="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv "
download.file(fileurl1, destfile="./data/GDP.csv", method="auto")
download.file(fileurl2, destfile="./data/EDU.csv", method="auto")
GDP = read.csv("./data/GDP.csv", stringsAsFactors=FALSE, header=FALSE)
EDU = read.csv("./data/EDU.csv", stringsAsFactors=FALSE, header=FALSE)
head(GDP, 20); tail(GDP, 20); head(EDU, 20); tail(GDP, 20)          ## carefully examine the data
gdpData <- GDP[6:195, ]; eduData <- EDU[2:235, ]
df1 = data.frame(id=gdpData$V1, 1:190)
df2 = data.frame(id=eduData$V1, 1:234)
arrange(join(df1, df2), id)
gdpData[order(gdpData$V2, decreasing = TRUE), ]

meltData = melt(mergedData, id=c("V1", "V2.x"), measure.vars="V3.y")