getcleandatacoursera
====================

Course Project, getdata-006

#* Introduction

The R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement. 
1. Uses descriptive activity names to name the activities in the data set
1. Appropriately labels the data set with descriptive variable names. 
1.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The data linked to from the course website represent data collected
from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.Data for the project:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.

#* Preparation
The original data set is to be downloaded and unzipped in the R working directory

#* Description of the script

* Begin step 1
* Read and create data frames from the training data set

```{r}

strain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")

```
* Combine subject, activity, and feature columns into the train data frame
```{r}
mtrain <- cbind(strain, ytrain, xtrain)
```
* Read and create data frames from the test data set
```{r}
stest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
```
* Combine subject, activity, and feature columns into the test data frame
```{r}
mtest <- cbind(stest, ytest, xtest)
```
* Merge the training and test set to create one data set
```{r}
mdata <- rbind(mtrain, mtest)
```
* Read and create data set column names from features file
```{r}
feature <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
colnames(mdata) <- c("subject", "activity", feature[,2])
```
* mdata is the merged data set with column names
* End step 1

There are no mean or standard deviation measurements for the variables associated with angles.

* Begin Step 2
* Extract the columns assoicated with the mean of each measurement

```{r}
mean <- mdata[,grep("mean", colnames(mdata))]
```

* Extract the columns associated with the standard deviation of each measurement
```{r}
std <- mdata[,grep("std", colnames(mdata))]
```
* Combine subject, activity, mean, standard deviation columns into one data frame
```{r}
ext <- cbind(mdata[,1:2], mean, std)
```
* End step 2

* Begin step 3
* Convert the six activiites from numeric to descriptve names
* The decriptive names are from the README in the original data set
```{r}
ext$activity <- as.factor(ext$activity)
levels(ext$activity) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
```
* End step 3

* Begin step 4
* Create temporary vector from column names for editing
tmpnames <- names(ext)
* Each of the following gsub to make the variable names more descriptive or easier to read
* Remove dashes and brackets characters
```{r}
tmpnames <- gsub("-|\\()", "", tmpnames)
```
* Expand leading "t" to "Time"
```{r}
tmpnames <- gsub("^t", "Time", tmpnames)
```
* Expand leading "f" to "FFT"
```{r}
tmpnames <- gsub("^f", "FFT", tmpnames)
```
* Expand "std" into "StandardDeviation"
```{r}
tmpnames <- gsub("std", "StandardDeviation", tmpnames)
```
* Expand "Gyro" to "Gyroscope".
```{r}
tmpnames <- gsub("Gyro", "Gyroscope", tmpnames)
```
* Expand "Acc" to "Acceleration"
```{r}
tmpnames <- gsub("Acc", "Acceleration", tmpnames)
```
* Expand "Mag" to "Magnitude"
```{r}
tmpnames <- gsub("Mag", "Magnitude", tmpnames)
```
* Change "mean" to "Mean", easier to read
```{r}
tmpnames <- gsub("mean", "Mean", tmpnames)
```
* Put all the changes into the data set
```{r}
colnames(ext) <- tmpnames
```
* End step 4

* Begin step 5
* The melt function from reshape2 puts all the measurements
* (mean and standard deviation) in the same column
* subject and activity columns are "id" variables, not altered
```{r}
melted <- melt(ext, id.vars = c( "subject","activity"))
```
* The ddply function from plyr applys the summarise function to all the
* subsets (subject and activity)
* The resuling data frame has the average of each variable for each
* activity and each subject
```{r}
tidy <- ddply(melted, c( "subject","activity"), summarize, mean = mean(value))
```
* Write the data set into a text file
```{r}
write.table(tidy, file = "tidy.txt", row.names = FALSE)
```
* End step 5

### Description of tidy.txt

Tidy.txt is a tidy data set with the average of each variable for each activity and each subject. This is "tidy" according to the general principles by [Hadley Wickham](http://had.co.nz/)

1. Each variable measureed should be in one column
1. Each different observation of that variable should be in a different row
1. There should be one table for each "kind" of variable

The tidy.txt data set is a table with 180 rows by 3 columns. 30 subject each does 6 activities, resulting in 180 rows of observations. The "subject" column is the ids, 1 to 30. The "activity" column is the six activities. The "mean" column is the average of each of the measusemnents.
