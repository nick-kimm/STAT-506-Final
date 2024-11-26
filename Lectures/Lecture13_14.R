#Lecture 13 
#tidyverse continued

library(tidyverse)

1:3 %>% mean %>% sqrt

#put in an argument as . then it'll put it in there instead of default as 1st arg
mtcars %>% lm(mpg~.,data=.)

x<-(-1):5
x<-x %>% abs
library(mgritter)
x%<>%abs

#built in piping in r
#you need to have the () for functions
x|>mean()
#use _ instead of . for built in 
mtcars |> lm(mpg~.,data=_)

#contains is for exact strings, matches for regular expression 

#this functions will return what is in the 2nd position in the string
switch(2,"A","B","C")

#switch can NOT take in multiple arguments in the first statment, instead have to use apply
sapply(2:3,switch,"a","b","c")

#mutate is changing the dataset values, row by row

#in tidyverse it operates sequentially. Can call var names all in one as var with become existed after its first operation

#filter will pull out certain rows 
#summarize, will create a custom column where it does some operations

#in most cases you want long form data over wide

##Plotting 

#will treat it as a date
as.Date()

#can plot using formulas 
#plot(temp~date)

#bad way to add data var
#this will all mmaps to your variables in this area DANGEROUS
attach(mmaps)
o3
detach(mmpas)

#better version: will do attach and deattach automatically in this one line and will avoid possible overlap of attach and so on
with(mmaps,plot(o3~date))
#can run for multiple lines of code need to put in in {}

#to color add col to plot(): it only works for numeric var so will have to convert to factors 
#levels in as.factor() is to assign your own way of ordering compared to R's default of alphabetic 

#to collaspe data
aggregate(mmapa, by =list(mmaps$year,mmaps$month_numeric),
          FUN = means, na.rm=TRUE)

#point(), lines() will plot a pt or line graph ontop of an exisitng plot 

#par() are global plotting parameters 











