#Part 2: Longitudinal Data Class and Methods
#The purpose of this part is to create a new class for representing longitudinal data, which is data that is collected over time on a given subject/person. This data may be collected at multiple visits, in multiple locations. You will need to write a series of generics and methods for interacting with this kind of data.

#The data for this part come from a small study on indoor air pollution on 10 subjects. Each subject was visited 3 times for data collection. Indoor air pollution was measured using a high-resolution monitor which records pollutant levels every 5 minutes and the monitor was placed in the home for about 1 week. In addition to measuring pollutant levels in the bedroom, a separate monitor was usually placed in another room in the house at roughly the same time.

#Before doing this part you may want to review the section on object oriented programming (you can also read that section here).

#The data are available as a CSV file and here:
#read csv file
longitudinaldata <- read.csv("./data/MIE.csv", sep = ",")
summary(longitudinaldata)
#You will need to design a class called “LongitudinalData” that characterizes the structure of this longitudinal dataset. You will also need to design classes to represent the concept of a “subject”, a “visit”, and a “room”.
LongitudinalData <- setRefClass("LongitudinalData",
                                fields = list(
                                  id = "integer",
                                  visit = "integer" ,
                                  room = "character" ,
                                  value = "numeric" , 
                                  timpoint = "integer"
                                ),
                                methods = list(
                                  subject.LongtitudinalData = function(){
                                    
                                  },
                                  print.LongtitudinalData = function(){}
                                  
                                  
                                  ))

#In addition you will need to implement the following functions

#make_LD: a function that converts a data frame into a “LongitudinalData” object
#subject: a generic function for extracting subject-specific information
#visit: a generic function for extracting visit-specific information
#room: a generic function for extracting room-specific information
