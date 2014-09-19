---
title: "README"
author: "Chris Dickson"
date: "Friday, September 19, 2014"
output: html_document
---

Once added as source to session simply run_analysis() to create the tidy output text file.

Please see codebook for more details on transformations and calculations undertaken.

The analysis script breaks down into 5 main parts

1. Loading the data into a data frame 
```{r}
# Read in training main file
training <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)

#Add YTrain Column
trainingy <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training <- cbind(training,trainingy)

#Add Subject Column
trainingS <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
training <- cbind(training,trainingS)

#Tidy Up
rm(trainingy)
rm(trainingS)

#Read in Testing main file
testing <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)

#Add Y Test column
testingy <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing <- cbind(testing,testingy)

#Add Subject Test column
testingS <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
testing <- cbind(testing,testingy)

#Tidy Up
rm(testingy)
rm(testingS)

# Merge training and test sets together
allData <- rbind(training, testing)
```

2. Loading the column headers and tidying them up according the R convention
```{r}
# Read features and tidy feature names
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] <- gsub('-mean', 'Mean', features[,2])
features[,2] <- gsub('-std', 'Std', features[,2])
features[,2] <- gsub('[-()]', '', features[,2])

# Add the column names (features) to allData 
colnames(allData) <- c(features$V2, "Activity", "Subject")
```

3. Subsetting the dataset to only include the Mean and Standard Deviation
```{r}
# Get only the data on mean and std. dev.
colsWeWant <- colnames(allData)[grep(".*Mean.*|.*Std.*", colnames(allData))]

# Now add the last two columns (Subject and Activity)
colsWeWant <- c(colsWeWant, "Activity", "Subject")

# And remove the unwanted columns from allData
allData <- allData[,colsWeWant]
```

4. Bring in descriptive labels for the actvities
```{r}
#Get activity labels
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
colnames(activityLabels)<- c("Activity","ActivityName")

#Bring activity labels into dataset
allData <- merge(allData,activityLabels)
```

5 Finally creating the tidy dataset with aggregated variables and outp[utting as a text file
```{r}
#Convert Subject to a factor
allData$Subject <- as.factor(allData$Subject)

#List fields not to be aggregated
droplist <- c("ActivityName", "Activity", "Subject")

#Calculate Means of columns
tidyData <- aggregate(allData[,!(names(allData) %in% droplist)], by=list(ActivityName = allData$ActivityName, Subject=allData$Subject), mean)

write.table(tidyData, "tidy.txt", sep="\t",row.name=FALSE )
```