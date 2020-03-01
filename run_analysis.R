## Get the Data and import the activity labels and features
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" ## Store the URL
download.file(url, "./Dataset.zip", method = "curl") ## Download the Zip File
unzip("./Dataset.zip") ## unzip the files in the current directory
labels <- read.table("./UCI HAR Dataset/activity_labels.txt") ## name of the activity per code
features <- read.table("./UCI HAR Dataset/features.txt") ## colnames of the X_test and X_train
features$V2 <- as.character(features$V2) ## change the class from factor to character to use it as colnames in the future
library(plyr) ## the plyr package to join() without messing the sort

## Import the Test Data set
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") ## import the activity codes
y_test_labels <- join(y_test, labels, by = "V1") ## names to the activity by code without sorting join() is from plyr
names(y_test_labels) <- c("test", "activity") ## rename the columns
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt") ## import the observations

        ## Change the colnames of x_test to be more descriptive
oldNames <- c(names(x_test))
newNames <- c(features$V2)
setnames(x_test, oldNames, newNames)


        ## Binding the subject and activity to the x_test
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- c("subject")
x_test_bind <- cbind(subject_test, y_test_labels, x_test)

## Import the Train Data set
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt") ## import the activity codes
y_train_labels <- join(y_train, labels, by = "V1") ## names to the activity by code without sorting join() is from plyr
names(y_train_labels) <- c("test", "activity") ## rename the columns
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt") ## import the observations

## Change the colnames of x_train to be more descriptive
oldNames <- c(names(x_train))
setnames(x_train, oldNames, newNames)

## Binding the subject and activity to the x_train
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- c("subject")
x_train_bind <- cbind(subject_train, y_train_labels, x_train)

## Merging the test and train data set
fullDataSet <- rbind(x_test_bind, x_train_bind)

## Subseting measurements based on the mean and standard deviation
colnames <- colnames(fullDataSet)
subsetLogical <- (grepl("[Mm]ean",colnames)|grepl("std|STD",colnames)|grepl("subject",colnames)|grepl("activity",colnames))
mean_std_DataSet <- fullDataSet[, subsetLogical == TRUE]

## Subseting with the average of each variable for each activity and each subject and ordering it
averageTidyDataSet <- aggregate(. ~subject + activity, mean_std_DataSet, mean)
averageTidyDataSet <- averageTidyDataSet[order(averageTidyDataSet$subject, averageTidyDataSet$activity),]

        ## Tidy the colnames to be more "Human readable"        
colnamesTidy <- colnames(averageTidyDataSet)
colnamesTidy<- gsub("-","",colnamesTidy)
colnamesTidy<- gsub("\\(\\)","",colnamesTidy)
colnamesTidy<- gsub("^t","Time",colnamesTidy)
colnamesTidy<- gsub("^f|Freq","Frequency",colnamesTidy)
colnamesTidy<- gsub("BodyBody","Body",colnamesTidy)
colnamesTidy<- gsub("Acc","Accelerometer",colnamesTidy)
colnamesTidy<- gsub("Gyro","Gyroscope",colnamesTidy)
colnamesTidy<- gsub("Mag","Magnitude",colnamesTidy)
colnamesTidy<- gsub("std","STD",colnamesTidy)
colnamesTidy<- gsub("mean","Mean",colnamesTidy)
colnames(averageTidyDataSet) <- colnamesTidy

## Writing the final tidy data set to file
write.table(averageTidyDataSet, "tidy_data_set.txt", row.name=FALSE)