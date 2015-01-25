Welcome to this github repository that contains my course project repository for the Coursera course Getting and cleaning data (https://class.coursera.org/getdata-010/).

# Contents of this repository
This github repository contains the following three files:

* __README.md__: this file.
* __run_analysis.R__: a R script that will perform data analysis on the UCI HAR Dataset.
* __CodeBook.md__: a file that explains the result data format of the run_analysis.R script.

# How to run the data analysis script
This sections explains what to do to be able to execute the run_analysis.R script to get the correct result.

## R packages needed
The script requires the following packages to be installed prior to running it:
* __dplyr__ (tested with version 0.4.1)
* __tidyr__ (tested with version 0.2.0)

If you do not have them installed already you can install them like this from the R/Rstudio prompt:
<pre>
install.packages(“dplyr”)
install.packages(“tidyr”)
</pre>

## Required steps before running the script
To run the script you will need the data set it operates on: UCI HAR Dataset.
* First download the data set: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Unzip the file into a directory of your choice. Be sure to retain the folder structure as the zip file has.
* Download the run_analysis.R script from this github repository and save it in the root of the unzipped directory. Other files in this directory should include activity_labels.txt, features_info.txt etc.

## Run the script
To run the script:
* Start R or Rstudio
* Change the working directory to the same folder you saved the run_analysis.R script per the instruction above.
* Enter the following and press enter to load and execute the script:
<pre>
source("run_analysis.R")
</pre>

## Script output
Upon execution the script will load and process the UCI HAR Dataset. The result will be a table written to result.txt in the working directory. This table is a tidy data set of the wide kind. It’s dimensions are 180 rows by 68 columns. The CodeBook.md file explains each column.

# Decisions and assumptions
This sections explains my major decisions and assumptions made during the course of solving this project assignment. Note that the script itself also contains step by step comments that explain what is done in each step.

## Feature selection
The original data set has 561 features. The project description states to “Extracts only the measurements on the mean and standard deviation for each measurement”. My decision was here to only use the 66 features that contains the sub string “mean()” or “std()” because according to the features_info.txt these are true mean and standard deviation values while meanFreq() for example is a weighted average and does not in my mind fit with the project instruction.

## Column names
I have made sure that there are no white spaces, punctuation, hyphens or underscores in any column names. Apart from that I have not made any changes. Part of the reason is that I do not feel confident enough for some of the names and did not want to obfuscate or risk confusion. Even if std and Acc etc are a type of abbreviation I feel they are acceptable at this time because  longer column names may be more difficult to handle.

## Result format
The project instruction states that the result must be a tidy data set. I have decided to go for the wide format where the features are in the columns.

# Miscellaneous
This section covers some information that did not fit into another heading.

## Tools and versions
The development of the script was done in R Studio 0.98.1091 on Mac OSX 10.9 running R version 3.1.2 (2014-10-31).
