#setwd("~/Desktop/) setting working directory
#dtr() checking working directory

#mydata <- read.csv("",sep=",") storing dataset to mydata

#write.csv(mydata,file="") creating a csv

#atomic vectors: c(2,3) is a collection of vectors 
#5L just means integer 5

#mode() is more generic in that it sets it as "numeric"
#typeof() is more specific in that it specifics "integer" for example

#Inf = infinity is stored as a "double"

#NaN = not a number stored as "double"

#NA = is a logical but we treat it as a numeric 
#can store logicals w/ numerics b/c R will conver logical to numeric 

#c() is empty vector, typeof would be "NULL"

#vector() is the vector function
#ex. vector("character, length=10)
#for efficiency sake it would be better to create the correct length of the vector to substitute 
#values into rather than appending onto a vector into

#when appending, R is 1 indexed NOT 0 

#4:9 creates a continuous vector all values from 4 to 9 

#drop vectors through negative 
#ex. v[-(1:3)]

#v[-1:3] will create a vector starting from -1 to 3 not dropping first element 

#DON'T USE T and F
#this is b/c TRUE and FALSE are protected so can't accidently override TRUE to be another value
#T and F AREN'T protected

#list(1,"a") will store any value types together 
#downside is it's harder to subset out
#typeof(list) is "list" 

#sapply(l,typeof) give me typeof everything inside the list stored as l
#will apply any function to every element in the list

l = list(1,"a")
l[1] #will pull list in that position 
l[[1]] #will get element inside the list

#think bag inside bag analogy 

r = list(c(1,2),c("a","b","c"))
r[[2]][3] #will go into 2nd bag and pull out the 3rd element in that bag

r[[1:2]] #don't use, won't work the way we think it would

#can assign names to elements
b=c("first"=1,"second"=2)
#names() will pull out just the names, can use this to change names 
names(b)
names(b) <- c("uno","dos")

list(a=1,b=2)

#class() is lot more general than mode and tyepof

class(1)
class(1L)

a
class(a) <- c("cat")
#will attach it as an attribute, can do multiple 

a <- c(1,2)
class(a)
class(a) <- "character"
a
#will change all elements in class to characters

m<-matrix(c(1,2,3,4),nrow=2) #create a 2 by 2 
typeof(m) #is double
mode(m) #is numeric
class(m) #is matrix
length(m)

dim(2) #2 2
dim(m) <- c(1,4) #changes dim of the matrix

#to subset in matrix need to elements
m[1,1] #first row, first column
m[1,] #if left blank give me everything in that column in this case


m[1,,drop=FALSE] #if we could drop a dimension DON'T, will keep it as a row vector or column
m[1,] #will give you a vector w/o regard of shape of the matrix

#matrix can't store multiple types since it is a combo of vectors
#dataframes will break this restriction

#R is COLUMN DOMININATE
matrix(1:9,nrow=3) #will fill in 1,2,3 is filled top to bottom
matrix(1:9,nrow=3,byrow=TRUE)

attributes(m)

#can pull out elements in attributes w/ $
#ex. attributes(b)$names

#attr(b,"names")<-c("a","b") can add on a,b and store is named as names

#attr(b,"animals")<-NULL will delete everything stored under NULL

#a dataframe is a list of vectors
df<-data.frame(a=1:4,
           b=c("a","b","c","d"),
           c=c(TRUE,TRUE,NA,NA))
#does not have dim

?runif #will run help file of runif
runif(4) #doesn't have to specify the name as can assign either by pos or name

#can break positioning if you named or if all other var are named except for the last one

#there is also something called default values which means if not called will use these values

sum(1,2,3)
?sum() #notice triple dot (...)
#can put in any number in here

#in lm() case its in end so all arguments MUST be named 

foo <- function(){
  print(3)
} #is a function that defines a function

#if you call foo with () it prints out the function

foo

#if there is no return() R will output the very last line of code inside the function

#if you take mean w/ NA it will equal NA
mean(c(2,4,NA))
#way to counteract this is through mean(x,na.rm=TRUE)

#roxygen is a package that'll make a help document for a function or package you create

#can insert a roxygen doc code inside rstudio

#' Test function
#' 
#' Description what it does
#' 
#' Details of what it does
#' 
#' @prom x is defining what x does in the function
#'
#' @return what is the function returning in this case nothing
#' @export
#'
#' @examples
#' type example below
test <- function(x){
  
}

?switch

