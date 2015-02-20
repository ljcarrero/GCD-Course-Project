# GCD-Course-Project
Course Project for the Coursera Course Getting and Cleaning Data

This is the script requested by the course project. In general terms, the steps taken to porduce the final tidy data are:

1. Reading the feature and activity labels.
2. Creating training and test data frames by separate.
3. Joining both data frames into one by using rbind and ordering by subject.
4. The final data frame with the means by subject and activity is created using the <plyr> function "ddply" to find the means by each group of activity and subject in the dataframe.
5. The final text file "tidy.txt" is created using write.table as requested.

Thanks and I hope this description of my sctript is helpful.
