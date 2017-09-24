This CODEBOOK.md contains an explanation of the "data_tidy.R" script and the data transformations performed on the UCI HAR Dataset downloaded as part of the Week 4 assignment for the Getting and Cleaning Data course on Coursera.

# Background and Purpose
The UCI HAR dataset contains the data from experiements on 30 volumteers within the age bracket of 19-48 years.  Each volunteer wore a smartphone on his or her waist and data from the various sensors were recorded for each of 6 activities ("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying").  This data was then processed to create 561 measurement variables, and then randomly divided into "Test" and "Train" datasets.  More information on the UCI HAR Dataset is contained in the README.txt file included with the dataset.

The purpose of the "data_tidy.R" script is to merge the various data tables in the dataset into a single,  tidy dataset for further analysis.  "data_tidy.R" reads the various data tables into R, merges the "Test" and "Train" datasets and performs various transformations to tidy the data.  It's output is a separate, tidy data table containing the average of each measurement variable for each activity and each test subject.

# Before using the script
Prior to utilizing the "data_tidy.R script for these transformations, the UCI HAR Dataset should be downloaded from the Coursera webpage for the Week 4 assignment of the Getting and Cleaning Data course (https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project).  The should be unzipped onto a local directory and the file directory for this unzipped dataset should be copied and pasted into the "data_tidy.R" script.  This ensures that the script is able to find the dataset for analysis.

The "dplyr" package is requried for this script to function properly and must be installed prior to using.  This package is called within the "data_tidy.R" script.

# Description of "data_tidy.R"
The "README.txt" file included with the UCI HAR Dataset includes a complete description of various data tables called in this "data_tidy.R" script.  These include:

* 'features.txt': List of all measurement variable labels.
* 'activity_labels.txt': Contains a table of activity numbers and their corresponding activity labels ("walking", "walking_upstairs", etc.).
* 'train/X_train.txt': Measurement variables for subjects included in the "Train" dataset.
* 'train/y_train.txt': Activity numbers for each observation in the "Train" dataset.
* 'train/subject_train.txt': Subject numbers for each observation in the "Train" dataset.
* 'test/X_test.txt': Measurement variables for subjects included in the "Test" dataset.
* 'test/y_test.txt': Activity numbers for each observation in the "Test" dataset.
* 'test/subject_test.txt': Subject numbers for each observation in the "Test" dataset.

"Data_tidy.R" accomplishes five main tasks, as prescribed by the Week 4 assignment.  The sections of script that accomplish each tasks are also noted in the script comments:

## Merges the training and the test sets to create one data set.
The above data tables in the UCI HAR Dataset are read into R for both the "Test" and "Train" data.  After reading these data tables into R, the subject labels and activity labels are merged with the corresponding observation data, for each of the "Train" and "Test" datasets, independently.  These compiled "Test" and "Train" data frames are then merged into a single data frame "data".

## Extracts only the measurements on the mean and standard deviation for each measurement.
The R object "feats" is a table containing row numbers in the first column and a vector of labels for the 561 measurement variables in the second column.  A search on the second column of the "feats" object is performed using the "grep" function for labels containing either "std" or "mean" in the variable name.  The locations of these labels is contained in the R object "selectColumns".  The corresponding columns of the "data" data frame are then subsetted into a separate data frame called "data2".

## Uses descriptive activity names to name the activities in the data set.
The table "alabels" contains a column of activity numbers and a second column of corresponding descriptive labels for activities ("walking", "walking_upstairs", etc.).  The "sapply" function is used on the column of "data2" corresponding to activity (column named "v1.1"), to replace each activiy number with its corresponding descriptive label.

## Appropriately labels the data set with descriptive variable names.
The labels "subject" and "activity" are used to label the first two columns of the "data2" data frame.  The remaining columns contain the measurement variables for each observation, and must be labeled accordingly.  The data table "feats" contains the descriptive variable names for these columns (the locations for which are stored in the "selectColumns" object), but contain additional characters (namely, "-" and "()") that, if removed, would make further data processing easier.  These characters are removed using the "gsub" function and stored in a new object called "names".  Columns containing measurement variables are then relabeled using the "names" vector.

## From the data set above, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In order to perform operations on the "data2" data frame by subject and by activity (in that order), the "group_by" function is used.  The summarize function is then called to calculate the mean of the measurement variables by these groups.  The results of these operations are stored in a separate data frame called "data3".  This data frame is then exported into a text file called "grouped"averages.txt".  This output file is also uploaded to this repository.

# Description of the output file "grouped_averages.txt"
The output file contains a tidy dataset of observations from the UCI HAR Dataset.  Each observation (in rows) contains the following variables (in columns)":

* 'subject': contains integer subject labels for each observation
* 'activity': contains descriptive character labels of the activity each observation corresponds to ("walking", "walking_upstairs", etc.)
* Measurement variables: there are 561 measurment variables contained in the original UCI HAR Dataset.  In the "grouped_averages.txt" output file, these columns contain the mean of data from each subject-activity pair for each of these measurement variables.  A more detailed description of these measurement variables is provided in the "features_info.txt" file contained with the original UCI HAR Dataset.  Variable labels in the "grouped_averages.txt" output file correspond to a subset of these variables that contain average or standard deviation data (i.e. contain "mean" or "std" in the variable name), with special characters (namely "-" and "()") removed.
