Getting and Cleaning Data - Peer Assignment CodeBook
----------------------------------------------------
    
* The data for the project is from the: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The 'run_analysis.R' script Description: 
 * Read train files including 'X_train.txt', 'y_train.txt' , 'subject_train.txt' files and store them in 'trainData', 'trainLabel' , 'trainSubject' variables.       
 * Read test files including 'X_test.txt', 'y_test.txt' , 'subject_test.txt' files and store them in 'testData', 'testLabel' , 'testsubject' variables.  
 * Merge 'testData' and 'trainData' to generate 'mergedData' data frame, Merge 'testLabel'and 'trainLabel' to generate
 'mergedLable'data frame, merge 'testSubject' and  'trainSubject' to generate 'mergedSubject' data frame.  
 * Read the 'features.txt' file and store the data in  'features' variable.
 We just need the measurements on the mean and standard deviation not all the data frame.
 * Clean the column names of the subset.   
 * Read the activity_labels.txt file and store the data in the 'activities'variable.  
 * Transform the values of 'mergedLabel' to the 'activities' data frame.  
 * Combine the 'mergedSubject', 'mergedLabel' and 'mergedData' by column to get a new cleaned  data frame, 'cleanedData'. 
 * Write the 'cleanedData' to 'merged_data.txt' file to create the text file we need.  
 * generate a tidy data set 'tidyDat' with the average of each measurement for each activity and each subject. 
 * Write the 'tidyData' to "data_with_means.txt" file in order to have the tidy data set in text format. 
 
