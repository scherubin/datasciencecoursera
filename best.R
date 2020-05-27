#reading in the outcome data
outcome <- 
  read.csv("~/Coursera JHU course/Data/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses="character")
head(outcome)

#creating a histogram of the 30-day deaths
death30 <- as.numeric(outcome[,11])
hist(death30)

#creating a dataset with the 30-day mortality rates from
#all three outcomes, sate code and hospital names
best_rate <- data.frame(outcome[,c(2,7,11,17,23)])
best_rate <- rename(best_rate, heart_attack = names(best_rate[3]), heart_failure = names(best_rate[4]), pneumonia = names(best_rate[5]))
head(best_rate)
tail(best_rate)

#creating dataset with the 30-day mortality rate from
#a specified outcome for a specific state
state_data <- (best_rate[best_rate$State == "TX", "heart_attack"])


#finding the index of the minimum value
which.min(best_rate$heart_attack)
#finding the associated hospital
best_rate[2850,"Hospital.Name"]
#putting it together
best_rate[which.min(best_rate$heart_attack), "Hospital.Name"]
