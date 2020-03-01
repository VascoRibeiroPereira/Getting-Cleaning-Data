The `run_analysis.R` script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

### Download the data set

Data set downloaded and extracted under the folder called `UCI HAR Dataset`

### Assign each data to variables

`features` <- `features.txt` : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

`labels` <- `activity_labels.txt` : 6 rows, 2 columns 
List of activities performed when the corresponding measurements were taken and its codes (labels)

`subject_test` <- `test/subject_test.txt` : 2947 rows, 1 column 
contains test data of 9/30 volunteer test subjects being observed

`x_test` <- `test/X_test.txt` : 2947 rows, 561 columns 
contains recorded features test data

`y_test` <- `test/y_test.txt` : 2947 rows, 1 columns 
contains test data of activities’code labels

`subject_train` <- `test/subject_train.txt` : 7352 rows, 1 column 
contains train data of 21/30 volunteer subjects being observed

`x_train` <- `test/X_train.txt` : 7352 rows, 561 columns 
contains recorded features train data

`y_train` <- `test/y_train.txt` : 7352 rows, 1 columns 
contains train data of activities’code labels

### Merges the training and the test sets to create one data set

1. `y_test` and `y_train` where each merged by using the plyr __join()__, with labels creating the `y_test_labels` (2947 rows, 2 columns) and `y_train_labels` (7352 rows, 2 columns)
2. `x_train_bind` (7352 rows, 564 columns) is obtained by merging `subject_train`, `y_train_labels` and `x_train` using __cbind()__
3. `x_test_bind` (2947 rows, 564 columns) is obtained by merging `subject_test`, `y_test_labels` and `x_test` using __cbind()__
4. `fullDataSet` (10299 rows, 564 columns) is created by merging `x_train_bind` and `x_test_bind` using __rbind()__ function

### Extracts only the measurements on the mean and standard deviation for each measurement

`mean_std_DataSet` (10299 rows, 88 columns) is created by subsetting `fullDataSet`, selecting only columns: `subject`, `activity` and the measurements on the `mean` and standard deviation (`std`) for each measurement

### Uses descriptive activity names to name the activities in the data set

`y_test_labels` and `y_train_labels` contained the descriptive activity names and where previously merged in the data set

### From the data set in last step, creates a second, independent data set with the average of each variable for each activity and each subject

`averageTidyDataSet` (180 rows, 88 columns) is created by summarizing `mean_std_DataSet` taking the means of each variable for each activity and each subject, after grouped by subject and activity, by using __aggregate()__

### Appropriately labels the data set with descriptive variable names - tidy data set Finale

- All `-` in column’s name deleted
- All `()` in column’s name deleted
- All start with character `f` or `Freq` in column’s name replaced by `Frequency`
- All start with character `t` in column’s name replaced by `Time`
- All `Acc` in column’s name replaced by `Accelerometer`
- All `Gyro` in column’s name replaced by `Gyroscope`
- All `BodyBody` in column’s name replaced by `Body`
- All `Mag` in column’s name replaced by `Magnitude`
- All `std` in column’s name replaced by `STD`
- All `mean` in column’s name replaced by `Mean`

### Export tidy data set

Export `averageTidyDataSet` into `tidy_data_set.txt` file.
