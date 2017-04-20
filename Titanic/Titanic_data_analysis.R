

# loading data
train <- read.csv("train.csv", header = TRUE, stringsAsFactors = FALSE)#do not convert strings into categories
test <- read.csv("test.csv", header = TRUE, stringsAsFactors = FALSE)

# adding a "survived" variable to the test set (and renaming it) to allow for combining data sets
test.survived <- data.frame(Survived = rep("None", nrow(test)), test[,]) #[,] means using all 
#rows and columns, here I'm combining them with a new one called Survived filled with None


#creating a new df with selected columns of another df
#mytest <- test[,c("Ticket","Sex")] #or
mytest <- subset(test, select = c(Ticket,Sex,Pclass))
#to drop a column:
mytest <- subset(mytest, select = -c(Sex))


# or I can add a column 'Survived' with NA values to the actual data set 'test':
#test$Survived <- NA

# combining, or appending datasets: joining them vertically, to do hor. use cbind
data.combined <- rbind(train, test.survived)

#data type
str(data.combined)

data.combined$Survived <- as.factor(data.combined$Survived)
data.combined$Pclass <- as.factor(data.combined$Pclass)#it was an integer, but it should really 
#be seen as a Factor (categorical data)
train$Pclass <- as.factor(train$Pclass)
train$Pclass<- as.integer(train$Pclass)


# Now let's see the rate of survival

table(data.combined$Survived)
# we see, more people died, almost twice as much as survived, so one should bare this in
#mind when trying to make a prediction, because the best bet is, of course, that the individual died

# Now, let's see the distribution of classes
table(data.combined$Pclass)

#Load ggplot2 for viz
library(ggplot2)

#converting Pclass Survived to categorical on the fly
ggplot(train,aes(x = factor(Pclass), fill = factor(Survived))) + 
  stat_count(width = 0.5) + #geom_histogram(binwidth=0.5) didn't work
  #stat_bin(binwidth = 0.5)+ # also works, looks good too
  xlab("Pclass")+
  ylab("Total Count")+
  labs(fill = "Survived")
 
#But I also want to know the numbers, the exact percentage depicted in the plot
prop.table(table(train$Pclass,train$Survived),1)# #1 here means row-wise, #2 column-wise

#Let's repeat the analysis with Sex

ggplot(train,aes(x = factor(Sex), fill = factor(Survived))) + 
  stat_count(width = 0.5) + #geom_histogram(binwidth=0.5) didn't work
  #stat_bin(binwidth = 0.5)+ # also works, looks good too
  xlab("Sex")+
  ylab("Total Count")+
  labs(fill = "Survived")

prop.table(table(train$Sex,train$Survived),1)
