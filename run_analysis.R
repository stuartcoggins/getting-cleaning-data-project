library(reshape2)

setwd("/Users/stuart/week3project")

features <- read.table("features.txt", stringsAsFactors = F, col.names = c("feature_id", "feature_name"))
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
subject_test <- read.table("test/subject_test.txt", col.names = "subject")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt", col.names = "activity_id")

activities <- read.table("activity_labels.txt", stringsAsFactors = F, col.names = c("activity_id", "activity_name"))

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt", col.names = "activity_id")

colnames(x_train) <- features$feature_name
colnames(x_test) <- features$feature_name

train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)

test <- merge(activities, test, by = "activity_id")
train <- merge(activities, train, by = "activity_id")

test <- test[, c(grep("subject|activity_name|mean()|std()", colnames(test)))]
train <- train[, c(grep("subject|activity_name|mean()|std()", colnames(train)))]

test <- test[, -c(grep("Freq", colnames(test)))]
train <- train[, -c(grep("Freq", colnames(train)))]

x <- rbind(test, train)


colnames(x) <- gsub("tBodyAcc-mean()", "BodyAccelerationTimeMean", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyAcc-std()", "BodyAccelerationTimeStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("tGravityAcc-mean()", "GravityAccelerationTimeMean", colnames(x), fixed = T)
colnames(x) <- gsub("tGravityAcc-std()", "GravityAccelerationTimeStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyAccJerk-mean()", "BodyAccelerationJerkTimeMean", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyAccJerk-std()", "BodyAccelerationJerkTimeStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyGyro-mean()", "BodyGyroscopeMean", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyGyro-std()", "BodyGyroscopeTimeStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyGyroJerk-mean()", "BodyGyroscopeJerkTimeMean", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyGyroJerk-std()", "BodyGyroscopeJerkTimeStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyAccMag-mean()", "BodyAccelerationMagnitudeTimeMean", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyAccMag-std()", "BodyAccelerationMagnitudeTimeStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("tGravityAccMag-mean()", "GravityAccelerationMagnitudeTimeMean", colnames(x), fixed = T)
colnames(x) <- gsub("tGravityAccMag-std()", "GravityAccelerationMagnitudeTimeStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyAccJerkMag-mean()", "BodyAccelerationJerkMagnitudeTimeMean", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyAccJerkMag-std()", "BodyAccelerationJerkMagnitudeTimeStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyGyroMag-mean()", "BodyGyroMagnitudeTimeMean", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyGyroMag-std()", "BodyGyroMagnitudeTimeStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyGyroJerkMag-mean()", "BodyGyroJerkMagnitudeTimeMean", colnames(x), fixed = T)
colnames(x) <- gsub("tBodyGyroJerkMag-std()", "BodyGyroJerkMagnitudeTimeStandardDeviation", colnames(x), fixed = T)

colnames(x) <- gsub("fBodyAcc-mean()", "BodyAccelerationFrequencyMean", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyAcc-std()", "BodyAccelerationFrequencyStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyAccJerk-mean()", "BodyAccelerationJerkFrequencyMean", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyAccJerk-std()", "BodyAccelerationJerkFrequencyStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyGyro-mean()", "BodyGyroFrequencyMean", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyGyro-std()", "BodyGyroFrequencyStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyAccMag-mean()", "BodyAccelerationMagnitudeFrequencyMean", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyAccMag-std()", "BodyAccelerationMagnitudeFrequencyStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyBodyAccJerkMag-mean()", "BodyAccelerationJerkMagnitudeFrequencyMean", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyBodyAccJerkMag-std()", "BodyAccelerationJerkMagnitudeFrequencyStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyBodyGyroMag-mean()", "BodyGyroscopeMagnitudeFrequencyMean", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyBodyGyroMag-std()", "BodyGyroscopeMagnitudeFrequencyStandardDeviation", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyBodyGyroJerkMag-mean()", "BodyGyroscopeJerkMagnitudeFrequencyMean", colnames(x), fixed = T)
colnames(x) <- gsub("fBodyBodyGyroJerkMag-std()", "BodyGyroscopeJerkMagnitudeFrequencyStandardDeviation", colnames(x), fixed = T)


x_melt <- melt(x, id = c("activity_name", "subject"), measure.vars = colnames(x[, 3:68]))

final <- dcast(x_melt, subject + activity_name ~ variable, mean)

write.table(final, "output.txt", row.name = FALSE)