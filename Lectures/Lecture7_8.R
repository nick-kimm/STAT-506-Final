#Debugging 

#Harder to debugging in a function since can't run line by line 

print(paste("a",1)) #will combine 2 strings together 

#use print to get a peak in the box. See what's going on under the hood.

#could do if(x %% 20 == 0){print(i)} in a for loop to act as a % complete bar

#<<- saves things into your global enviroment no matter where it is located.
#This could be helpful to see how an object looks like if you're storing values in it in a function 

#However this isn't the best soltuion 

#The best solution is browser:
browser()
#this will throw you into the browser in the console where you can do multiple checks with the varnames
#used inside the function.
#put browser outside of the for loop 

#Should have 1 browser call inside function. Unless you have a special case where you have branching logic 

#debug(function_name) will go into browser every time you run the function. 
#Can do this to already built in functions in R like lm()

#What if you have functions calling other functions how do you debug?
#use browser() and there are 2 options called "step into"
#be careful b/c if you hit "enter" browser will run the last thing you entered. If the last thing you did was step
#into a function it'll keep step into things

tracestack() #will return where in the stack the error occurred 
#this can be more useful in the case where you're calling a function inside a function 
#the at #_ is the line number in the function 

install.packages("profvis")
library(profvis)

#code will profile: where we are in the stack, take a picture of it
#profile works better for much longer simulations 

#if you are copies of things multiple times it may be quick but will be very inefficeint memory wise

#this profile will make you be able to spot slow lines of your code

#review of dim
c(1,2) + c(2,3,4)

c(1,2) * matrix(1:6,nrow=2)

#the c() vector is dimensionless. We'll end of with the larger matrix 

##Model fitting 

ff<-3~2 
#~ will create what is known as a formula

typeof(ff)
#languages are an entirely different obj

#this is simply writing the equation down but not checking if its actually true or not
#this becomes useful for linear regression model 

#lm(form, data = )

#this is how to remove an intercept in a model 
lm(quec~disp+cyl+0,data=mtcars)
lm(quec~disp+cyl-1,data=mtcars)

#adding interaction term 
lm(quec~disp*cyl,data=mtcars) #the * will auto add the two var disp and cyl and the interaction 

lm(quec~disp:cyl,data=mtcars) #this will just give you the interaction term 

#if you want to not include a term just use "-"

lm(quec~.,data=mtcars) #will put in everything 

#summary() will give you more informative info

#predict() on a model will give you the fitted values 
#coefficients() on a model will return the b_0 in your model 

#adding polynomials in model 
lm(mpg~wt*wt,data=mtcars) #this will NOT add a polynomial interaction to wt

#3 ways to DO
mtcars$wtsq <- mtcars$wt^2
lm(mpg~wt+wtsq,data=mtcars) #don't do this 

lm(mpg~I(wt*wt),data=mtcars)
#I() = interpret this will mean when you get here don't treat as a formula but treat it as math 
lm(mpg~wt+I(wt*wt),data=mtcars)

lm(lm(mpg~poly(wt,degree=2),data=mtcars)) #this is best approach 
#poly() will do the standarization before hand for you 

#this is why the resulting coeff of the model w/ I() and poly() have different values but the same f-test and r^2

lm(lm(mpg~poly(wt,degree=2aw=TRUE,r),data=mtcars)) #this will NOT standarize which is better since its easier to interpret. Keeps it in its context

#the time it might be better to standardize is if the value of the unit is extremely large. 
#Adding interaction term to this value might be too big for calculation 

model.matrix() #will auto create a design matrix when you pass in the model name or formula 
model.matrix(mpg~wt+wtsq,data=mtcars)

form <- qsec~disp*cyl + poly(mpg,degree=2,raw=TRUE)
head(model.matrix(form,data=mtcars))

#cat var
vec <-c("a","b","b")
fvec <- as.factor(vec)
as.numeric(vec)
class(fvec) <- "numeric"
fvec 

mod<-lm(mpg~quex+cylf_disp+disp::vs.,data=mtcars)
model.matrix(mod,data=mtcars)
model.frame(mod,data=mtcars) #will only use a subset of the model to run the regression 

as.factor() #will treat a variable as categorical, otherwise it'll be numeric













