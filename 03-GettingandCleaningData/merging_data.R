##-------------------------Merging Data---------------------------
## download data

fileurl1="https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileurl2="https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileurl1, destfile="./data/reviews.csv", method="auto")
download.file(fileurl2, destfile="./data/solutions.csv", method="auto")
reviews = read.csv("./data/reviews.csv")
solutions = read.csv("./data/solutions.csv")
head(reviews, 2)
head(solutions, 2)

##------------------------merge()---------------------------------
## default will merge the same name of the two data frame
## For example "id", "start", "stop", "time_left" in this particular example

names(reviews)
names(solutions)

mergedData = merge(reviews, solutions, by.x="solution_id", by.y="id", all=TRUE)   ## merge function is based on the by.x one, all=TRUE means if there is a value that appears in one but not in the other, it should include a NA row
head(mergedData)

## merge all common column names

intersect(names(solutions), names(reviews))           ## tell which the names are in common
mergedData2 = merge(reviews, solutions, all=TRUE)
head(mergedData2)

## use join in the plyr package
## faster but less full featured
## advantage is in merge multiple data frames

df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), y=rnorm(10))
df3 = data.frame(id=sample(1:10), z=rnorm(10))
dfList = list(df1, df2, df3)
join_all(dfList)
arrange(join(df1, df2), id)