The dplyr package was loaded since the functions select, group_by were used in the transformations that were performed by the run_Analyis.R 
The run_Analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s instructions

I.Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

II.Assigning the data in the dataset to dataframes using the read.table function

i) features <- "/features.txt" : 561 rows, 2 columns
List of all features selected for this database, more information is provided in the feature_info.txt file
ii) activities <- "/activity_labels.txt" : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes, (i.e.)links labels with activity names
iii) subject_test <- "/test/subject_test.txt" : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed
iv) x_test <- "/test/X_test.txt" : 2947 rows, 561 columns
contains recorded test data
v) y_test <- "/test/y_test.txt" : 2947 rows, 1 columns
contains test data labels
vi) subject_train <- "/train/subject_train.txt" : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed
vii) x_train <- "/train/X_train.txt" : 7352 rows, 561 columns
contains recorded training data
viii) y_train <- "/train/y_train.txt : 7352 rows, 1 columns
contains train data labels

III. Merges the training and the test sets to create one data set

i. X_data (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function.
ii. Y_data (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function.
iii. Subject_data (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function.
iv. merged_data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function.

rbind() and cbind() were used instead of functions like merge or join because they maintain the number of rows and columns between X_data, Y_data, and Subject_data

IV.Extracts only the measurements on the mean and standard deviation for each measurement

Ex_data (10299 rows, 88 columns) is created by subsetting merged_data (via the select function), selecting only columns: subject, code ,and the measurements on the mean and standard deviation (std) for each measurement. 

V.Uses descriptive activity names to name the activities in the data set

Entire numbers in code column of the Ex_data replaced with corresponding activity name taken from second column of the activities dataframe.

VI.Appropriately labels the data set with descriptive variable names

'subject' column in Ex_data renamed to Subject
'code' column in Ex_data renamed into Activities
All 'BodyBody' in column’s name replaced by Body
All 'Mag' in column’s name replaced by Magnitude

VII.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

final_data (180 rows, 88 columns) is created by sumarizing Ex_data taking the means of each variable for each activity and each subject, after using the group_by function on Subject based on Activity as the factor variable.
Export final_data into finaldata.txt file via the write.table function.