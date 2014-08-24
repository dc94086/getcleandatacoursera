---
title: "codebook"
author: "Dan Chan"
date: "08/24/2014"
output: html_document
---

### Introduction

This codebook describes the data set, "tidy.txt", produced in the Getting and Cleaning Data Course
Project

### Data Source

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

Detailed desciptions of the measurements are included in the original data set.


### Description of tidy.txt

Tidy.txt is a tidy data set with the average of each variable for each activity and each subject. This is "tidy" according to the general principles by [Hadley Wickham](http://had.co.nz/)

1. Each variable measureed should be in one column
1. Each different observation of that variable should be in a different row
1. There should be one table for each "kind" of variable

The tidy.txt data set is a table with 180 rows by 3 columns

```{r}
> tidy <- read.table("tidy.txt", header = TRUE)
> summary(tidy)
    subject                   activity       mean        
 Min.   : 1.0   LAYING            :30   Min.   :-0.6311  
 1st Qu.: 8.0   SITTING           :30   1st Qu.:-0.6046  
 Median :15.5   STANDING          :30   Median :-0.4947  
 Mean   :15.5   WALKING           :30   Mean   :-0.4124  
 3rd Qu.:23.0   WALKING_DOWNSTAIRS:30   3rd Qu.:-0.2167  
 Max.   :30.0   WALKING_UPSTAIRS  :30   Max.   : 0.1312  
```

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
