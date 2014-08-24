## Geting and Cleaning Data
## Course Project
## The purpose of this project is to demonstrate the ability to collect,
## work with, and clean a data set.

## The data linked to from the course website represent data collected
## from the accelerometers from the Samsung Galaxy S smartphone. 
## A full description is available at the site where the data was obtained:
    
##    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## Data for the project:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## This R script performs the following project requirments:
## Steps:    
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Load and Attach libraries required by the script
library(plyr); library(reshape2)

## Before runing this sciprt, the source data set needs to be downloaded and unzipped
## in the working directory

# Begin step 1
## Read and create data frames from the training data set
strain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")

## Combine subject, activity, and feature columns into the train data frame
mtrain <- cbind(strain, ytrain, xtrain)

## Read and create data frames from the test data set
stest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")

## Combine subject, activity, and feature columns into the test data frame
mtest <- cbind(stest, ytest, xtest)

# Merge the training and test set to create one data set
mdata <- rbind(mtrain, mtest)

## Read and create data set column names from features file
feature <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
colnames(mdata) <- c("subject", "activity", feature[,2])

## mdata is the merged data set with column names
## End step 1

## Begin Step 2
## Extract the columns assoicated with the mean of each measurement
mean <- mdata[,grep("mean", colnames(mdata))]
## Extract the columns associated with the standard deviation of each measurement
std <- mdata[,grep("std", colnames(mdata))]
## Combine subject, activity, mean, standard deviation columns into one data frame
ext <- cbind(mdata[,1:2], mean, std)
## End step 2

## Begin step 3
## Convert the six activiites from numeric to descriptve names
## The decriptive names are from the README in the original data set
ext$activity <- as.factor(ext$activity)
levels(ext$activity) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
## End step 3

## Begin step 4
## Create temporary vector from column names for editing
tmpnames <- names(ext)
## Each of the following gsub to make the variable names more descriptive or easier to read
## Remove dashes and brackets characters
tmpnames <- gsub("-|\\()", "", tmpnames)
## Expand leading "t" to "Time"
tmpnames <- gsub("^t", "Time", tmpnames)
## Expand leading "f" to "FFT"
tmpnames <- gsub("^f", "FFT", tmpnames)
## Expand "std" into "StandardDeviation"
tmpnames <- gsub("std", "StandardDeviation", tmpnames)
## Expand "Gyro" to "Gyroscope"
tmpnames <- gsub("Gyro", "Gyroscope", tmpnames)
## Expand "Acc" to "Acceleration"
tmpnames <- gsub("Acc", "Acceleration", tmpnames)
## Expand "Mag" to "Magnitude"
tmpnames <- gsub("Mag", "Magnitude", tmpnames)
## Change "mean" to "Mean", easier to read
tmpnames <- gsub("mean", "Mean", tmpnames)
## Put all the changes into the data set
colnames(ext) <- tmpnames
## End step 4

## Begin step 5
## The melt function from reshape2 puts all the measurements
## (mean and standard deviation) in the same column
## subject and activity columns are "id" variables, not altered
melted <- melt(ext, id.vars = c( "subject","activity"))

## The ddply function from plyr applys the summarise function to all the
## subsets (subject and activity)
## The resuling data frame has the average of each variable for each
## activity and each subject
tidy <- ddply(melted, c( "subject","activity"), summarize, mean = mean(value))
## Write the data set into a text file
write.table(tidy, file = "tidy.txt", row.names = FALSE)
## End step 5
