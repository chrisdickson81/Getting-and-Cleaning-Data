Getting and Cleaning Data (Coursera). Course Project Codebook
==============================================================


## Original Data

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data llinked below represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained - [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


- [source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
- [description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Data sets

### Raw data set

The training and test subsets of the original dataset were combined to produce final raw dataset.

Original variable names were imported from `features.txt` file and modified in the following way in accordance with R variable naming good practice:

 1. Replaced `-mean` with `Mean`
 2. Replaced `-std` with `Std`
 3. Removed parenthesis `-()`

The raw dataset was created using the following regular expression to filter out required features, 
i.e. retaining the  mean and standard deviation for each measurement from the original feature vector set only 

`.*Mean.*|.*Std.*`

The subject identifiers `Subject` and activity labels `Activity` were also kept and the `ActivityName` was added for clarity of analyses.

### Tidy data set

Tidy data set contains the average of all filtered standard deviation and mean values from the raw dataset. Grouped by `Subject` and `ActivityName`.  

#### Sample of renamed variables compared to original variable name
For clarity on the affect of scripts described above had on variable names as seen in the tidy dataset when compared to if they had been left untouched from the original raw features file.

 Raw data            | Tidy data 
 --------------------|--------------
 `tBodyAcc-mean()-X` | `tBodyAccMeanX`
 `tBodyAcc-mean()-Y` | `tBodyAccMeanY`
 `tBodyAcc-mean()-Z` | `tBodyAccMeanZ`



