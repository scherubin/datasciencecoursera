#Importing and unzipping the datasets

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile = "samsung.zip")
unzip("samsung.zip")

##################### TEST #######################
#reading in the TEST data file
test <- read.table("UCI HAR Dataset/test/X_test.txt")
#reading in the ID files
id_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
#reading in the activity data
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
test_activity <- read.table("UCI HAR Dataset/test/y_test.txt")

## reading variable names
library(data.table)
var_names <- read.table("UCI HAR Dataset/features.txt")

#cleaning the TEST dataset
library(dplyr)        
new_test <- test %>%
                setnames(old=names(test), new = var_names$V2) %>%
                bind_cols(test_activity, id_test) %>%
                rename (activity = V1...562, id = V1...563) %>%
                merge(activity_labels, by.x ="activity", by.y="V1") %>%
                select(-activity) %>%
                rename(activity = V2) %>%
                select(id, activity, grep("mean|std", names(test)))


################### TRAIN #########################
#reading in the TRAIN data file
train <- read.table("UCI HAR Dataset/train/X_train.txt")
#reading in the ID files
id_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
#reading in the activity data
train_activity <- read.table("UCI HAR Dataset/train/y_train.txt")

#cleaning the TEST dataset
new_train <- train %>%
                        setnames(old=names(train), new = var_names$V2) %>%
                        bind_cols(train_activity, id_train) %>%
                        rename (activity = V1...562, id = V1...563) %>%
                        merge(activity_labels, by.x ="activity", by.y="V1") %>%
                        select(-activity) %>%
                        rename(activity = V2) %>%
                        select(id, activity, grep("(mean|std)", names(train)))

################## MERGE  ###################
#merging test and train datasets
library(tidyr)
library (stringr)
library(dplyr)
test_train <- bind_rows(new_test, new_train) %>%
        
                arrange (id) %>%
        
                pivot_longer("tBodyAcc-mean()-X":"fBodyBodyGyroJerkMag-meanFreq()",
                             names_to = "measurement", values_to= "values") %>%
               
                separate(measurement, into= c("measurement","statistic", "vector")) %>%
        
                separate(measurement, into = c("domain", "measurement"), sep = 1) %>%
                
        
                mutate(measurement= str_replace(measurement, "Mag", "-Mag")) %>%
        
                separate(measurement, into = c("measurement", "variable")) %>%

                mutate(vector = coalesce(variable, vector)) %>%
        
                select(id, activity, domain, measurement, vector, statistic, values, -variable)
                
             
########### AVERAGE BY ACTIVITY#############
library(tidyr)
average <- test_train %>% 
                group_by(vector, statistic, measurement, domain, activity, id) %>%
                
                mutate ( average = mean(as.numeric(values))) %>%
        
                select(-values) %>%
                
                unique()

#### saving the datasets####
write.csv(test_train, file = "test_train.csv")
write.csv(average, file = "average.csv")

