Getting-and-Cleaning-Data-Course-Project

This repository contains the project assignment for the Coursera Data Science Specialisation course Getting and Cleaning Data.

The repository consists of the required data, the required script run_analysis.R to run the full analysisand and a codebook which describes the final data set.  

The resulting datafile is df_answer.txt. The file is created by write.table with standard settings. The file can be read by read.table with standard settings. 

The script contains the code to download the data but this part is commented out as the data is already part of the repository.

The script assumes that your working directory is the repository folder.

The assignment specifies 5 steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Some remarks about the interpretation of the assignment:

Remarks Step 2: 
Only the mean() and meanFreq() are perceived as mean functions as mend in step 2. This can be debated of course. But such debate is not essential to the assignment

Remarks Step 4:
This step takes the original variable or feature names from the raw data.
The original variable or feature names from the raw data are used as presented in the features.txt file. Only the use of non alfabetic characters are replaced. The names are perceived as logical and readeble abbriviations. It is assumed that they are clear for the user group thus they don't need to be rewritten. 
As with the remarks to step 2 the choises made can be debated. However, I perceived the abbriviations clear and usable for the (specialised) usergroup of such data. Also, I perceive the remaining underscores and caps to improve readability over no underscores and caps. 



Remarks step order:
The script completes the steps in a different order.   
- The activity data is labeled directly after reading the activity data. 
- Variablesnames are added directly after reading the data. 

The order of the script is
- read the variable names needed for step 4
- read and label the training data according to steps 3 and 4
- read and label the test data according to steps 3 and 4
- merge the data according to step 1
- subset the data according to step 2
- summarise the data and create a tidy data frame according to step 5

The comments in the script will refer to the steps in the assignment by a number between parenthese 


