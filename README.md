Course Project
====================

Project repository for the Getting and Cleaning  Data Coursera course.

## The project description: 

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[The original data location](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

Here are the data for the project: 

[Project data location](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Steps to get the required tidy data sets:

1. Download the [project data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
2. Unzip it into your R working directory
3. Run/source the **run_analysis.R** file
4. The tidy data sets will be in the **persNamedActX** and **tidyMeanUCIHAR** tables in R, the second one is also the return value of the script. Both tidy data set will be also written out to text files into the working directory after running the script as **"cleanfullUCIHAR.txt"** and **"tidyMeanUCIHAR.txt"**.

## Content


### run_analysis.R

R script file performing the 5 points required in the project descrition.
The script assumes the unzipped downloaded dataset is in the working directory together with this script file.
The return value of the script is the second independent dataset with the average values grouped by the person and their activities. Both tidy data set will be also written out to text files into the working directory after running the script.

1. Merge the training and the test sets to create one data set.
The script goes through every file in the "train" and "test" subdirectories in the "UCI HAR Dataset" and concatenates the files as adding the test rows at the end of the train set into r tables. 
The new tablenames will be STH if the originals were STH_test.txt and STH_train.txt.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
First the script gets the mean and standard deviation features with their column number and name of the variable
then it extracts these columns from the concantenated new dataset, X.
3. Use descriptive activity names to name the activities in the data set
The script switches the activity numbers to the names according to the activity_labels.txt, merges the activities with the new dataset and adds the subjects to the dataset
4. Appropriately labels the data set with descriptive variable names.
The first column should be "Person", the second is "Activity" the remaining columns are the variable names from the filtered features vector. Write the table out as cleanfullUCIHAR.txt
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Save the tidy data to tidyMeanUCIHAR.txt 

## UCIHARCodebook.txt

The detailed description of the datasets in the cleanfullUCIHAR.txt and tidyMeanUCIHAR.txt output files.
