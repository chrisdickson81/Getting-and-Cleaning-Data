
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

# Read features and tidy feature names
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] <- gsub('-mean', 'Mean', features[,2])
features[,2] <- gsub('-std', 'Std', features[,2])
features[,2] <- gsub('[-()]', '', features[,2])

# Merge training and test sets together
allData <- rbind(training, testing)

# Add the column names (features) to allData 
colnames(allData) <- c(features$V2, "Activity", "Subject")

# Get only the data on mean and std. dev.
colsWeWant <- colnames(allData)[grep(".*Mean.*|.*Std.*", colnames(allData))]

# Now add the last two columns (Subject and Activity)
colsWeWant <- c(colsWeWant, "Activity", "Subject")

# And remove the unwanted columns from allData
allData <- allData[,colsWeWant]

#Get activity labels
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
colnames(activityLabels)<- c("Activity","ActivityName")

#Bring activity labels into dataset
allData <- merge(allData,activityLabels)

#Convert Subject to a factor
allData$Subject <- as.factor(allData$Subject)

#List fields not to be aggregated
droplist <- c("ActivityName", "Activity", "Subject")

#Calculate Means of columns
tidyData <- aggregate(allData[,!(names(allData) %in% droplist)], by=list(ActivityName = allData$ActivityName, Subject=allData$Subject), mean)

write.table(tidyData, "tidy.txt", sep="\t",row.name=FALSE )
