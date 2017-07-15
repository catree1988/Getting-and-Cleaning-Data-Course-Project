# Getting-and-Cleaning-Data-Course-Project

run_analysis.R does the following:

1.Download and read data, then merges the training and the test sets to create one data set through rbind function.

2.Extracts only the measurements on the mean and standard deviation for each measurement through grep and select function.

3.Uses descriptive activity names to name the activities in the data set through merge function, then deletes the numerical labels.

4.Appropriately labels the data set with descriptive variable names through grep and names function.

5.From the data set in step 4, creates a second, independent tidy data set "summarise" with the average of each variable for each activity and each subject through group_by and summarise function, then writes to the "summarise.txt" file.
