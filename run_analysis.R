# Reading features file an selecting only indexes with mean() or 
# std() in it

features<-read.csv("UCI HAR Dataset/features.txt",sep=" ",header=FALSE)
b <- sapply(features, is.factor)
features[b] <- lapply(features[b], as.character)
feature_index<-sort(c(grep('mean()',features$V2,fixed=TRUE),grep('std()',features$V2,fixed=TRUE)))

# Reading activity labels future use

activity_label<-read.table("UCI HAR Dataset/activity_labels.txt")
b <- sapply(activity_label, is.factor)
activity_label[b] <- lapply(activity_label[b], as.character)

# Creating training dataframe
#############################

# Reading and subsetting main data for training

traindf<-read.table("UCI HAR Dataset/train/X_train.txt",colClasses=numeric())
traindf<-traindf[,feature_index]
colnames(traindf)<-features$V2[feature_index]

# Reading subjects for training and adding to the main training table 

train_subj<-read.table("UCI HAR Dataset/train/subject_train.txt")
traindf<-cbind(train_subj,traindf)
colnames(traindf)[1]<-'subject'

# Reading activites for training and adding to the main table

train_act<-read.table("UCI HAR Dataset/train/y_train.txt")
train_act<-activity_label$V2[train_act$V1]

traindf<-cbind(train_act,traindf)
colnames(traindf)[1]<-'activity'

################################
# Creating test dataframe
#############################

# Reading and subsetting main data for test

testdf<-read.table("UCI HAR Dataset/test/X_test.txt",colClasses=numeric())
testdf<-testdf[,feature_index]
colnames(testdf)<-features$V2[feature_index]

# Reading subjects for test and adding to the main training table 

test_subj<-read.table("UCI HAR Dataset/test/subject_test.txt")
testdf<-cbind(test_subj,testdf)
colnames(testdf)[1]<-'subject'

# Reading activites for test and adding to the main table

test_act<-read.table("UCI HAR Dataset/test/y_test.txt")
test_act<-activity_label$V2[test_act$V1]

testdf<-cbind(test_act,testdf)
colnames(testdf)[1]<-'activity'

################################

#Joning the two dataframes and ordering by subject then by activiy

totaldf<-rbind(traindf,testdf)

library(plyr)
totaldf<-arrange(totaldf, subject, activity)


# Creating 2nd tidy data set

tidydf<-ddply(totaldf,.(activity,subject),numcolwise(mean))

# Writing final table to txt file

write.table(tidydf,"tidy.txt",row.name=FALSE)

