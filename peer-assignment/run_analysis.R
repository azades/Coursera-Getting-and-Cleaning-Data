# 1. Merges the training and the test sets to create one data set.
trainData <- read.table("./data/train/X_train.txt")
dim(trainData)
head(trainData)
trainLabel <- read.table("./data/train/y_train.txt")
table(trainLabel)
trainSubject <- read.table("./data/train/subject_train.txt")
testData <- read.table("./data/test/X_test.txt")
dim(testData)
testLabel <- read.table("./data/test/y_test.txt") 
table(testLabel) 
testSubject <- read.table("./data/test/subject_test.txt")
mergedData <- rbind(trainData, testData)
dim(mergedData)
mergedLabel <- rbind(trainLabel, testLabel)
dim(mergedLabel)
mergedSubject <- rbind(trainSubject, testSubject)
dim(mergedSubject)

# 2. Extracts only the features on the mean and standard deviation for each measurement. 
features <- read.table("./data/features.txt")
dim(features)
meanSDIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanSDIndices)
mergedData <- mergedData[, meanSDIndices]
dim(mergedData)
names(mergedData) <- gsub("\\(\\)", "", features[meanSDIndices, 2]) # remove "()"
names(mergedData) <- gsub("mean", "Mean", names(mergedData)) # capitalize M
names(mergedData) <- gsub("std", "Std", names(mergedData)) # capitalize S
names(mergedData) <- gsub("-", "", names(mergedData)) # remove "-" in column names 

# 3. Uses descriptive activities names to name the activities in the data set
activities <- read.table("./data/activity_labels.txt")
activities[, 2] <- tolower(gsub("_", "", activities[, 2]))
substr(activities[2, 2], 8, 8) <- toupper(substr(activities[2, 2], 8, 8))
substr(activities[3, 2], 8, 8) <- toupper(substr(activities[3, 2], 8, 8))
activitiesLabel <- activities[mergedLabel[, 1], 2]
mergedLabel[, 1] <- activitiesLabel
names(mergedLabel) <- "activities"

# Step4. Appropriately labels the data set with descriptive activities names. 
names(mergedSubject) <- "subject"
cleanedData <- cbind(mergedSubject, mergedLabel, mergedData)
dim(cleanedData) 
write.table(cleanedData, "merged_data.txt")

# 5. Creates a second, independent tidy data set with the average of each variable 
# for each activities and each subject. 
mergedSubjectLength <- length(table(mergedSubject)) 
activitiesLength <- dim(activities)[1] # 6
columnLength <- dim(cleanedData)[2]
tidyData <- matrix(NA, nrow=mergedSubjectLength*activitiesLength, ncol=columnLength) 
tidyData <- as.data.frame(tidyData)
colnames(tidyData) <- colnames(cleanedData)
row <- 1
for(i in 1:mergedSubjectLength) {
        for(j in 1:activitiesLength) {
                tidyData[row, 1] <- sort(unique(mergedSubject)[, 1])[i]
                tidyData[row, 2] <- activities[j, 2]
                cleanedData_subject <- i == cleanedData$subject
                cleanedData$activities <- activities[j, 2] == cleanedData$activities
                tidyData[row, 3:columnLength] <- colMeans(cleanedData[cleanedData_subject&cleanedData$activities, 3:columnLength])
                row <- row + 1
        }
}
head(tidyData)
write.table(tidyData, "data_with_means.txt") # second dataset

