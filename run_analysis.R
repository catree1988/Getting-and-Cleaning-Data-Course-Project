## 1.Download and read data, then merges the training and the test sets to 
## create one data set.
if (!file.exists("./data/UCI HAR Dataset")){
        dir.create("./data")
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl,destfile = "./data/Dataset.zip")
        unzip("./data/Dataset.zip",exdir = "./data")
}
library(plyr)
Xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
Xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
test_data <- cbind(Xtest,ytest,subject_test,rep("test",nrow(Xtest)))
train_data <- cbind(Xtrain,ytrain,subject_train,rep("train",nrow(Xtrain)))
names(test_data) <- c(1:length(Xtest),"label","subject","set")
names(train_data) <- c(1:length(Xtrain),"label","subject","set")
data <- rbind(test_data,train_data)
rm(Xtest,ytest,subject_test,Xtrain,ytrain,subject_train,test_data,train_data)

## 2.Extracts only the measurements on the mean and standard deviation for 
## each measurement.
features <- read.table("./data/UCI HAR Dataset/features.txt")
selected <- grep("mean\\(\\)|std\\(\\)",features[,2])
selected_data <- select(data,"label","subject","set",selected)

## 3.Uses descriptive activity names to name the activities in the data set.
labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
names(labels) <- c("label","activity")
selected_data <- merge(selected_data,labels)
selected_data <- select(selected_data,-label)

## 4.Appropriately labels the data set with descriptive variable names.
variable <- grep("mean\\(\\)|std\\(\\)",features[,2],value = TRUE)
names(selected_data) <- c("subject","set",variable,"activity")

## 5.From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
selected_data <- selected_data %>% as.tbl() %>% group_by(activity,subject)
summarise <- summarise_at(selected_data,variable,mean,na.rm=TRUE)
write.table(summarise,"./data/UCI HAR Dataset/summarise.txt",row.name=FALSE)

