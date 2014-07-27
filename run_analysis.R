## This script is doing the following tasks on the 
## Human Activity Recognition Using Smartphones dataset stored in the "UCI HAR Dataset" folder. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Merge the training and the test sets to create one data set.
## The script goes through every file in the "train" and "test" 
## subdirectories in the "UCI HAR Dataset" and concatenates the files
## as adding the test rows at the end of the train set into new tables. 
## The new names will be STH if the originals were STH_test.txt and STH_train.txt.
if (!file.exists("UCI HAR Dataset")) stop("Missing original dataset")
testfiles <- list.files("UCI HAR Dataset/test", pattern=".*txt$")
trainfiles <- list.files("UCI HAR Dataset/train", pattern=".*txt$")
if (length(testfiles) != length(trainfiles)) stop("Missing original files")
for(i in testfiles) {
  basename <- unlist(strsplit(i,"_"))[1]
  assign(paste(basename, "_test", sep=""), read.table(paste("UCI HAR Dataset/test/", basename, "_test.txt", sep="")))
  assign(paste(basename, "_train", sep=""), read.table(paste("UCI HAR Dataset/train/", basename, "_train.txt", sep="")))
  assign(basename, rbind(get(paste(basename, "_train", sep="")),get(paste(basename, "_test", sep=""))))
} 
## Extracts only the measurements on the mean and standard deviation for each measurement.
## First get the mean and standard deviation features with their column number and name of the variable
## Extract these columns from the concantenated new dataset, X.
features <- read.table("UCI HAR Dataset/features.txt")
filteredFeatures <- features[grepl("mean()|std()",features[,2]), ]
filteredX <-X[,filteredFeatures$V1]
## Use descriptive activity names to name the activities in the data set
## Switch the activity numbers to the names according to the activity_labels.txt 
## Merge the activities with the new dataset
## Add the subjects to the dataset
actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
namedY <- lapply(y,function(num) actLabels[num, 2])
namedActX <- cbind(namedY,filteredX)
persNamedActX <- cbind(subject, namedY, filteredX)
## Appropriately labels the data set with descriptive variable names.
## The first column should be "Person", the second is "Activity" the remaining columns
## are the variable names from the filtered features vector
for(i in 1:(length(colnames(persNamedActX)))) {
  if (i == 1) colnames(persNamedActX)[i] <- "Person"
  else if (i == 2) colnames(persNamedActX)[i] <- "Activity"
  else colnames(persNamedActX)[i] <- toString(filteredFeatures$V2[i-2])
}
## Write the table out as cleanfullUCIHAR.txt
write.table(persNamedActX, file = "cleanfullUCIHAR.txt")
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Save the tidy data to tidyMeanUCIHAR.txt 
tidyMeanUCIHAR <- ddply(persNamedActX, .(Person, Activity), colwise(mean))
write.table(tidyMeanUCIHAR, file = "tidyMeanUCIHAR.txt")
tidyMeanUCIHAR