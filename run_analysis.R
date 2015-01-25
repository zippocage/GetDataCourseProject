library(tidyr)
library(dplyr)

execute <- function() {
  
  ## Step 1 start - Merges the training and the test sets to create one data set
  
  ## first read in all the data
  print("Reading in general data files")
  
  # general data
  activity_labels <- read.table("activity_labels.txt")
  feature_labels <- read.table("features.txt")
  
  # test data
  print("Reading in test data files")
  test_subject <- read.table("test//subject_test.txt")
  test_features <- read.table("test//X_test.txt")
  test_activity <- read.table("test//y_test.txt")
  # combine test data into one data frame  
  test_data <- cbind(test_features, test_subject, test_activity)
  
  #training data
  print("Reading in training data files")
  train_subject <- read.table("train///subject_train.txt")
  train_features <- read.table("train//X_train.txt")
  train_activity <- read.table("train//y_train.txt")
  # combine training data into one data frame  
  train_data <- cbind(train_features, train_subject, train_activity)

  # now we have merged the training and the test data into one total data frame
  print("Merging test and training data")
  all_data <- rbind(test_data, train_data)
  ## Step 1 end
  
  ## Step 2 start - Extracts only the measurements on the mean and standard deviation for each measurement
  print("Extract only mean and standard deviation measurements")  
  names(feature_labels) <- c("featureColumn", "featureLabel")
  # remove all that do not have std() or mean() in the label name
  feature_labels <- feature_labels[grepl('[Ss]td\\(|[Mm]ean\\(', feature_labels$featureLabel),]
  # remove the paranthesis to make ok to be used for column names later
  feature_labels <- mutate(feature_labels, featureLabel = gsub("\\(\\)","",featureLabel))
  
  # now keep only the columns that correspond to the ones we filtered out above.
  # (we have reduced from 561 features to 66)
  # Note that we have to add the last two columns because they hold the subject and the activity
  all_data <- all_data[,c(feature_labels$featureColumn,c(562,563))]
  ## Step 2 end
  
  print("Appropriately label the data")
  
  ## Step 3 start - Uses descriptive activity names to name the activities in the data set
  
  # Set column names to enable a merge by same column names
  # note that merge does not keep the same order of the rows but since we have already merged the 
  # training and test data, this is not an issue
  names(activity_labels) <- c("ActivityId","Activity")
  names(all_data)[68] <- "ActivityId"
  all_data <- merge(all_data, activity_labels, sort = FALSE)
  #drop the ActivityId column that is not needed now that the factors are there
  all_data <- select(all_data, -ActivityId)
  ## Step 3 end
  
  ## Step 4 start - Appropriately labels the data set with descriptive variable names
  
  # name Subject column
  names(all_data)[67] <- "Subject"
  
  # There are some issues with the feature labels we need to fix
  # Fix 1: sub string BodyBody should just read Body
  feature_labels <- mutate(feature_labels, featureLabel = gsub("BodyBody","Body",featureLabel))
  # Fix 2: let's remove the hypens (and make sure mean and std start with capital letter)
  feature_labels <- mutate(feature_labels, featureLabel = gsub("-mean","-Mean",featureLabel))
  feature_labels <- mutate(feature_labels, featureLabel = gsub("-std","-Std",featureLabel))
  feature_labels <- mutate(feature_labels, featureLabel = gsub("-","",featureLabel))
  # now use the feature_labels to set the labes of the first 66 columns
  names(all_data)[1:66] <- feature_labels$featureLabel
  # Step 4 end
  
  print("Create tidy data set with average of each variable")
  
  
  ## Step 5 start - From the data set in step 4, creates a second, 
  ##                independent tidy data set with the average of each 
  ##                variable for each activity and each subject
  
  # first we grroup by subject and activity
  tidy_data <- group_by(all_data, Subject, Activity)
  # Now we summarize for each column (except Subject and Activity of course) with the mean function
  tidy_data <- summarise_each(tidy_data, funs(mean))
  
  # Step 5 end
  
  # the result must now be saved as a text file as per instruction in the assignment
  write.table(tidy_data, file = "result.txt", row.name=FALSE)
  
  print("Done! Result saved in result.txt")
}

execute()