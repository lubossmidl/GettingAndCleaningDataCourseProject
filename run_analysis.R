######################################################
# course project
######################################################

require(plyr)  #join, ...

print("read training data")
# read training data
training_x = read.csv("../UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
#head(training)
training_y = read.csv("../UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training_s = read.csv("../UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

print("read testing data")
# read testing data
testing_x = read.csv("../UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
#head(testing)
testing_y = read.csv("../UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing_s = read.csv("../UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

print("read metadata")
# read activity file
activity = read.csv("../UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE, col.names = c("activityid", "activity"))

# read features 
features = read.csv("../UCI HAR Dataset/features.txt", sep="", header=FALSE)
#head(features)


# 1. Merges the training and the test sets to create one data set.
training = cbind(cbind(training_x, training_y), training_s)
col_y = 562 # activity
col_s = 563 # subject
testing = cbind(cbind(testing_x, testing_y), testing_s)

all <- rbind(training, testing)
features<-rbind(features, data.frame(V1=562,V2="ActivityID"))
features<-rbind(features, data.frame(V1=563,V2="Subject"))
labels <-  tolower(features$V2)
#labels <-  features$V2
names(all) <- labels

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
all_mean_std <- all[,grepl("mean|std|subject|activity|activityid", names(all))]

# 3. Uses descriptive activity names to name the activities in the data set
all_mean_std <- join(all_mean_std, activity, by = "activityid", match = "first")

# 4. Appropriately labels the data set with descriptive variable names. 
# partialy done in step 1
names(all_mean_std) <- gsub('[-(),]',"",names(all_mean_std))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
new = all_mean_std[,-1] # ignore firt col - activity ID
tidy <-  ddply(new, c("subject","activity"), numcolwise(mean))
write.table(tidy, file = "tidy.txt", row.name=FALSE )


