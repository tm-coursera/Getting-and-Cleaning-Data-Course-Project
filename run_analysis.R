## Assignment Getting and Cleaning Data
#' The steps in the assignment are ordered as 
#' 1. Merges the training and the test sets to create one data set.
#' 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#' 3. Uses descriptive activity names to name the activities in the data set
#' 4. Appropriately labels the data set with descriptive variable names.
#' 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#' In this script, these steps are somewhat reordered to the taste of the script writer
#' The activity data is labeled directly after reading the activity data. 
#' This is step 3 in the assignment
#' Variablesnames are added directly after reading the data.
#' This is step 4 in the assignemnt
#' 
#'  The order of the script is
#'  - read and label the training data according to steps 3 and 4
#'  - read and label the test data according to steps 3 and 4
#'  - merge the data according to step 1
#'  - subset the data according to step 2
#'  - summarise the data and create a tidy data frame according to step 5

# Set your working directory correctly if needed
wd.path <- "put your wd path here"
setwd(wd.path)
getwd( )


## Load libaries ####
library(dplyr)
library(tidyr)
library(stringr)


## Download the  data ####

#' The following lines can be used to download and connect to the required data
#' As the zip file is already part of the repository, the codelines for downloading
#' the file are commented out
#' If required the codelines can be uncommented  

# Create a Data folder in your wd if it does not yet exist
# if (!file.exists("Data")){ dir.create("Data")}

# Create a download path to your working directory
# path_download <- file.path(getwd(),"Data")

# download file only the first time
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", path_download)

## unzip and read the feature names and activity labels ####

# (4a) unzip and read the feature names
#' This step takes the original variable or feature names from the raw data.
#' First remark : These names are kept close to original to be able to stay as clearly and close to the 
#' original raw data and make it easier to identify the variables. However, parentheses 
#' commas and minus signs are replaced to make the variables usable in a database or programming 
#' environment. Underscores are used for readability but as little as possible. 
#' Second remark : The names are perceived as logical and readeble abbriviations.
#'                 It is assumed that they are clear for the user group thus they
#'                 don't need to be rewritten. 
 
con_features <- unz("./Data/getdata_projectfiles_UCI HAR Dataset.zip", 
                    "UCI HAR Dataset/features.txt")
features <- read.table(con_features, row.names = 1, stringsAsFactors = FALSE)

featuresvector <- features[[1]] %>%
        gsub(pattern="\\(\\)",replacement="", x=.) %>% # removes the ()
        gsub(pattern="\\)$", replacement= "", x=.) %>% # removes ) at the end of the variable
        gsub(pattern="\\(", replacement= "from", x=.) %>% # replaces ( for "from"
        gsub(pattern="\\)", replacement= "_", x=.) %>% # replaces ) within the variable for _ instead of "" for readability
        gsub(pattern=",", replacement= "and", x=.) %>% # replaces , for and
        gsub(pattern="-", replacement= "_", x=.) # replaces - for _ instead of "" for readability


# The variable featuresvector will be used to add descriptive column names to 
# the data as required by step 4

# unzip and read the activity labels
con_activity <- unz("./Data/getdata_projectfiles_UCI HAR Dataset.zip", 
                    "UCI HAR Dataset/activity_labels.txt") 
activitylabels  <- read.table(con_activity, col.names = c("level", "label"))


#### Reading and labeling the training data ####

# (4b) unzip and read  the xtrain dataset and name the columns
con_xtrain <- unz("./Data/getdata_projectfiles_UCI HAR Dataset.zip",
                  "UCI HAR Dataset/train/X_train.txt")

xtrain <- read.table(con_xtrain, col.names = featuresvector, check.names = FALSE) 

# (3a) unzip read and label the ytrain dataset
con_ytrain <- unz("./Data/getdata_projectfiles_UCI HAR Dataset.zip",
                  "UCI HAR Dataset/train/y_train.txt")

ytrain <- read.table(con_ytrain, col.names = "activity") %>% 
        # label the activity data
        mutate(activity = factor(activity, levels = c(1,2,3,4,5,6), # label data
                                 labels = c("WALKING", "WALKING_UPSTAIRS", 
                                            "WALKING_DOWNSTAIRS", "SITTING",
                                            "STANDING", "LAYING") ))

# (4c) unzip, create and read the subjecttrain data
con_subjecttrain <- unz("./Data/getdata_projectfiles_UCI HAR Dataset.zip",
                        "UCI HAR Dataset/train/subject_train.txt")

subjecttrain <- read.table(con_ytrain, col.names = "subject") # label variable


#### Reading and labeling the test data ####


# (4d) unzip and read the xtest dataset and name the columns
con_xtest <-  unz("./Data/getdata_projectfiles_UCI HAR Dataset.zip",
                  "UCI HAR Dataset/test/X_test.txt")

xtest <- read.table(con_xtest, col.names = featuresvector, check.names = FALSE) # label the variables

# (3b) unzip, read and label the ytest dataset
con_ytest <-  unz("./Data/getdata_projectfiles_UCI HAR Dataset.zip",
                  "UCI HAR Dataset/test/y_test.txt")

ytest <- read.table(con_ytest, col.names = "activity") %>% # label the variable
        # label the activity data
        mutate(activity = factor(activity, levels = c(1,2,3,4,5,6), 
                                 labels = c("WALKING", "WALKING_UPSTAIRS", 
                                            "WALKING_DOWNSTAIRS", "SITTING",
                                            "STANDING", "LAYING") ))

# (4e) unzip and read the subjecttest data
con_subjecttest <- unz("./Data/getdata_projectfiles_UCI HAR Dataset.zip",
                        "UCI HAR Dataset/test/subject_test.txt")

subjecttest <- read.table(con_subjecttest, col.names = "subject")

## Close all connections ####

closeAllConnections()

## Merge all relevant data frames ####

# (1) Merge all relevant data frames to one data frame

# (1a) concatenate the training activity and training data
traindf <- bind_cols(subjecttrain, ytrain, xtrain)

# (1b) concatenate the the test activity and test data
testdf <- bind_cols(subjecttest, ytest, xtest)

# (1c) Merge the training and test data 

df1 <- bind_rows(traindf, testdf)

## Subset the data to the relevant variables ####

# (2) Subset the data to the subject, activity and means and st.dev. variables

#  (2a) Get the indices of columns with data on means and standard deviation only 
# Remark : Only the mean() and meanFreq() are perceived as mean functions as mend in 
# step 2. This can be debated of course. But such debate is not essential to the assignment

df1_names <- names(df1) %>%
        grep(pattern = "(*mean*|*std*|*meanFreq*)" , x = .) #old grep statement "(*[Mm]ean*|*std*|*meanFreq*)"



# (2b) Subset the data with subject, activity and std and mean variables
df2 <- df1[,c(1,2,df1_names)]

## Create a tidy data frame with the means for all variables per person per activity ####

# (5) Calculate the average for each mean and std variable per person per activity
df_answer <- df2 %>%
        group_by(subject, activity) %>% # group by subject and activity
        summarise_at(vars(3:81) , funs(mean_ = mean), na.rm=TRUE) 
        # by using the funs(mean_ = mean) statement the text _mean_ is added to each
        # variable for which the mean is calculated 
        

# create a text file with the final tidy dataset
write.table(df_answer, file="dt_tidy.txt")

testread <-read.table("dt_tidy.txt", check.names = FALSE)

