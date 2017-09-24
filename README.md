Date created: 9/24/2017
Author: mmcg110


The files contained in this repository are intended to respond to the Week 4 assignment of the Getting and Cleaning Data course on Coursera (https://www.coursera.org/learn/data-cleaning/home/welcome).  The purpose of this assignment was to demonstrate an ability to collect, work with, and clean a data set, with the goal of producing a tidy data table for further processing.

The UCI Human Activity Recognition (HAR) Dataset is used for this analysis, and can be downloaded from the Week 4 webpage (https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project).  This data is processed and tidied using the "data_tidy.R" script that reads the various data tables contained in the UCI HAR Dataset into R and performs several transformations to tidy the data.  Tidy data is stored in the output file "grouped_averages.txt".

Files contained in this repository are:

* "data_tidy.R": R script used to tidy data tables contained in the UCI HAR Dataset.
* "CODEBOOK.md": Codebook for the "data_tidy.R" script explaining the analysis conducted.
* "grouped_averages.txt": Output file from "data_tidy.R" containing a tidy data table with the average of each variable for each activity and each subject of the UCI HAR Dataset.

