# load dplyr package and set working directory to location where "UCI HAR Dataset" is unzipped 
# BE SURE TO UPDATE THE "directory" OBJECT BELOW WITH LOCAL LOCATION OF "UCI HAR Dataset"

library(dplyr)
directory <- "FILE LOCATION OF UCI HAR DATASET"
setwd(directory)


# 1. read files into R and create single dataset
#### read activity and feature files

alabels <- read.table("activity_labels.txt"); feats <- read.table("features.txt"); 

#### read test files and merge

setwd(".//test")
xtest <- read.table("X_test.txt"); ytest <- read.table("y_test.txt"); subtest <- read.table("subject_test.txt")
setwd(".//..")

test <- cbind(subtest, ytest, xtest)

#### read train files and merge

setwd(".//train")
xtrain <- read.table("X_train.txt"); ytrain <- read.table("y_train.txt"); subtrain <- read.table("subject_train.txt")
setwd(".//.."); setwd(".//..")

train <- cbind(subtrain, ytrain, xtrain)

#### merge test and train

data <- rbind(test, train)


#2. Extract only measurements for mean and std for each measurement
####subset merged dataset to select only measurement columns that correspond to measurements containing "mean" or "std" labels (skipping first two columns containing activity and subject labels)

selectColumns <- grep("mean|std", feats$V2) 
data2 <- data[, c(1, 2, (selectColumns + 2))]  ## accounts for the first two columns of "data" we do not want to subset


#3. Use descritive activity names to name activities in data
#### Substitute activity numbers in data2 with activity labels

data2$V1.1 <- sapply(data2$V1.1, function(x){alabels[x==alabels$V1,2]})
  

#4. Label the data with descriptive variable names
#### remove special characters from variables names stored in "feats"

names <- gsub("-", "", feats$V2[selectColumns])
names <- gsub("\\()", "", names)

colnames(data2) <- c("subject", "activity", as.character(names))


#5. Create separate tidy table with average for each variable by subject and activity
#### Group by subject, then activity and use summarize_all function to create an average of each variable for each group

data3 <- data2 %>% group_by(subject, activity) %>% summarize_all(funs(mean))

#### Write data table to file "grouped_averages.txt"

write.table(data3, file = "grouped_averages.txt")

print("Tidying Complete")



