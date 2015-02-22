#Load libraries
library(data.table)
#download and unzip if not done already
if(!file.exists("UCI HAR Dataset")){
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        
        download.file(url, "ucidata.zip")
        unzip("ucidata.zip")
}
#read in the files
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", header = TRUE)
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", header = TRUE)
subjtest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = TRUE)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = TRUE)
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = TRUE)
subjtrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = TRUE)
features <- read.table("UCI HAR Dataset/features.txt")

#rename Columns
setnames(xtest, old = names(xtest), new = as.character(features$V2))
setnames(xtrain, old = names(xtrain), new = as.character(features$V2))
#bind the data frames together
xtest$activity <- ytest$X5
xtest$subject <- subjtest$X2
xtrain$activity <- ytrain$X5
xtrain$subject <- subjtrain$X1
use <- rbind(xtest, xtrain)

#Subset the data frame down to just means and stds
use <- use[,grepl("(mean|std|activity|subject)",names(use))]
drops <- names(use[,grepl("(Freq)",names(use))])
use <- use[,!(names(use) %in% drops)]

#Replace the numbers with descriptive variable names in use$activity
x <- use$activity
x[x==1] <- "WALKING"
x[x==2] <- "WALKING_UPSTAIRS"
x[x==3] <- "WALKING_DOWNSTAIRS"
x[x==4] <- "SITTING"
x[x==5] <- "STANDING"
x[x==6] <- "LAYING"
use$activity <- x
#Create a final data frame that gives us the mean of 
#each variable by each subject and activity

df.1 <- aggregate(use[,1:66], list(use$subject), mean)
df.2 <- aggregate(use[,1:66], list(use$activity), mean)
df.final <- rbind(df.1, df.2)
colnames(df.final)[1] <- "SubjectOrVariable"

write.table(df.final, "final.txt", row.name=F)