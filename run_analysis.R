library(reshape2)
## Loading all the files and merging them
x_train <- read.table(file="UCI HAR Dataset/train/X_train.txt", header = F)
y_train <- read.table(file="UCI HAR Dataset/train/y_train.txt", header = F, stringsAsFactors = F)
sub_train <- read.table(file="UCI HAR Dataset/train/subject_train.txt", header = F, stringsAsFactors = F)

x_test <- read.table(file="UCI HAR Dataset/test/X_test.txt", header = F)
y_test <- read.table(file="UCI HAR Dataset/test/y_test.txt", header = F, stringsAsFactors = F)
sub_test <- read.table(file="UCI HAR Dataset/test/subject_test.txt", header = F, stringsAsFactors = F)

features <- read.table(file="UCI HAR Dataset/features.txt", header = F, stringsAsFactors = F)
activities <- read.table(file="UCI HAR Dataset/activity_labels.txt", header = F, stringsAsFactors = F)

#Setting the variable names correctly
colnames(x_train) <- features[,2]
colnames(x_test) <- features[,2]

#Giving the right activity names, adding the subject and merging the datasets
y_train_fac <- factor(y_train$V1, levels = activities$V1, labels = activities$V2)

x_train <- cbind("train",sub_train, y_train_fac, x_train)

colnames(x_train)[1:3] <- c("soure", "subject", "activity")

y_test_fac <- factor(y_test$V1, levels = activities$V1, labels = activities$V2)

x_test <- cbind("test", sub_test, y_test_fac, x_test)

colnames(x_test)[1:3] <- c("soure", "subject", "activity")

merged_set <- rbind(x_test, x_train)


#selecting only mean and std variables for the final dataset
tidy_mean_set <- merged_set[,c(1:3,grep("*mean*|*std*", colnames(merged_set)))]

#wrting the final clean dataset
write.table(tidy_mean_set ,file = "mean_std_tidy_set.txt",  row.name=FALSE)

#using reshape2 to build the means of every variable from the tidy dataset for each subject and activity
tidy_mean_set_melt <- melt(tidy_mean_set, id.vars = c("soure", "subject", "activity"))

reduced_means <- dcast(tidy_mean_set_melt, subject + activity ~ variable, fun.aggregate = mean)

#write the dataset with the means per subject and activity
write.table(reduced_means ,file = "mean_activity_per_subject.txt",  row.name=FALSE)




