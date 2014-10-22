######################################################
# course project
######################################################
# 1. Merges the training and the test sets to create one data set.
print("hello")
# read training data
training_x = read.csv("../UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
head(training)
training_y = read.csv("../UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training_s = read.csv("../UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
# combine together
training = cbind(training_x, training_y, training_s)
col_y = 562
col_s = 563
# read testing data
testing_x = read.csv("../UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
head(testing)
testing_y = read.csv("../UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing_s = read.csv("../UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
# combine together
testing = cbind(testing_x, testing_y, testing_s)

