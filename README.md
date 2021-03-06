## Peer-graded Assignment: Getting and Cleaning Data Course Project

This repository is a __Vasco Pereira__ submission for Getting and Cleaning Data course project. It has the instructions on how to run analysis on Human Activity recognition data set.

## Data set

[Human Activity Recognition Using Smartphones](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Files

`CodeBook.md` a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data

`run_analysis.R` performs the data preparation and then followed by the steps required as described in the course project’s definition:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

*Note: the steps were not performed exactly by the order described due to my low experience in this subject*

`tidy_data_set.txt` is the exported final data after going through all the sequences described above.