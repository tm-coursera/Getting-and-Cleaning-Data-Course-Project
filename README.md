Getting-and-Cleaning-Data-Course-Project

This repository contains the project assignment for the Coursera Data Science Specialisation course Getting and Cleaning Data.

The repository consists of the required data, the required script run_analysis.R to run the full analysisand and a codebook which describes the final data set.  

The resulting datafile is df_answer.txt. The file is created by write.table with standard settings and can thus be read by read.table with standard settings. 

The script contains the code to download the data but this part is commented out as the data is already part of the repository. 

The assignment specifies 5 steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script completes the steps in a different order.   
- The activity data is labeled directly after reading the activity data. 
- Variablesnames are added directly after reading the data. 

The order of the script is
- read and label the training data according to steps 3 and 4
- read and label the test data according to steps 3 and 4
- merge the data according to step 1
- subset the data according to step 2
- summarise the data and create a tidy data frame according to step 5

The comments in the script will refer to the steps in the assignment by a number between parenthese 


