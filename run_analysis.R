# Merges the training and the test sets to create one data set

xtrain <- read.table("F:/coursera/p2/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("F:/coursera/p2/UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("F:/coursera/p2/UCI HAR Dataset/train/subject_train.txt")
xtest  <- read.table("F:/coursera/p2/UCI HAR Dataset/test/X_test.txt")
ytest  <- read.table("F:/coursera/p2/UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("F:/coursera/p2/UCI HAR Dataset/test/subject_test.txt")
traindata <- cbind(subjecttrain,ytrain,xtrain)
testdata <- cbind(subjecttest,ytest,xtest)
data <- rbind(traindata,testdata)

# Extracts only the measurements on the mean and standard deviation for each measurement.

features <-read.table("F:/coursera/p2/UCI HAR Dataset/features.txt")
featurenames <- features[,2]
index_for_mean_and_std <- grep(("mean\\(\\)|std\\(\\)"), featurenames)
data2 <- data[,c(1,2,index_for_mean_and_std+2)]

# Uses descriptive activity names to name the activities in the data set

activitynames <-read.table("F:/coursera/p2/UCI HAR Dataset/activity_labels.txt")
data2$V1.1 <-factor(data2$V1.1,levels = activitynames[,1], labels =activitynames[,2])

# Appropriately labels the data set with descriptive variable names
colnames(data2) <- c("subject","activity",featurenames[index_for_mean_and_std])

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
data3 <- group_by(data2,subject,activity)
data4 <- summarise_each(data3,mean)

