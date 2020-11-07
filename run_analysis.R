#Part 1: Reading and Merging datasets
#Reading train data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt") 
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt") 
s_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
#Reading test data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
s_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
#Merging data
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
s <- rbind(s_train, s_test)

#Parts 2,3: Naming the activities in data sets and extracting measurments
features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities[,2] <- as.character(activities[,2])
col <- grep("-(mean|std).*", as.character(features[,2]))
cnames <- features[col, 2]
cnames <- gsub("-mean", "Mean", cnames)
cnames <- gsub("-std", "Std", cnames)
cnames <- gsub("[-()]", "", cnames)

#Part 4: Labeling Datasets
x_data <- x_data[col]
all <- cbind(s, y, x)
colnames(all) <- c("Subject", "Activity", cnames)
all$Activity <- factor(all$Activity, levels = activities[,1], labels = activities[,2])
all$Subject <- as.factor(all$Subject)

#Part 5: 
allmelt <-melt(as.data.table(all), id = c('Subject', 'Activity'))
alltidy <- dcast(allmelt, Subject + Activity ~ variable, mean)
write.table(alltidy, file = "tidydataset.txt", row.names = FALSE)






