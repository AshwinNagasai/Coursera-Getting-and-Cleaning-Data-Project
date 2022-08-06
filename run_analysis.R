#Load necessary libraries
library(dplyr)
#Check if file & folder exists and acquire data from web

Project <- "project.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path <- "/Users/admin/Documents/data"
if(!file.exists(Project)){
    download.file(url,Project,method = "curl")
} 
if(!file.exists("UCI HAR Dataset")){
    unzip(Project)
}
#Assigning and reading all data frames

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", sep = "", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", sep = "", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", sep = "", col.names = "code")

#Step 1: Merges the training and the test sets to create one data set.

X_data <- rbind(x_train, x_test)
Y_data <- rbind(y_train, y_test)
Subject_data <- rbind(subject_train, subject_test)
merged_data <- cbind(Subject_data, X_data, Y_data)
# rbind and cbind were used to obtain an equal amount of rows and for efficiency purpose

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

Ex_data <- select(merged_data, subject, code, contains("mean"), contains("std"))

#Step 3: Uses descriptive activity names to name the activities in the data set.

Ex_data$code <- activities[Ex_data$code,2]

#Step 4: Appropriately labels the data set with descriptive variable names.

names(Ex_data)[2] <- "Activity"
names(Ex_data)[1] <- "Subject"
names(Ex_data)<-gsub("BodyBody", "Body", names(Ex_data))
names(Ex_data)<-gsub("Mag", "Magnitude", names(Ex_data))

#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

final_data <- Ex_data %>% group_by(Subject,Activity) %>% summarise_all(list(mean))

#Final Check - checking variable names

names(final_data)

#checking final_data

View(final_data)

#Writing it to a text file

write.table(final_data, "finaldata.txt", row.names = FALSE)