# Getting-and-Cleaning-Data
Coursera's Getting and Cleaning Data Course Project

To turn the UCI HAR Dataset into a tidy dataset, I completed several steps:

* I downloaded and unzipped the file into the working directory.

* I read in each of the seven data files needed to complete the tidying.

* I renamed each of the columns based on the features.txt file that was included originally.

* I bound each of the smaller data frames into one larger data frame.

* I created a subset of the larger data frame that contained all of the variables that
  contained the word "mean" ,"std", "activity", or "subject",  but did not contain "Freq".

* I replaced each of the numbers in the activity field with descriptive variable names.

* Finally, I created a final data frame that contained only the mean of each measurement
  by subject or activity and I wrote the data frame out to a file called final.txt.
  
