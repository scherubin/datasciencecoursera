#reading in the outcome data
outcome <- 
  read.csv("~/Coursera JHU course/Data/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses="character")
head(outcome)

#creating a histogram of the 30-day deaths
death30 <- as.numeric(outcome[,11])
hist(death30)
