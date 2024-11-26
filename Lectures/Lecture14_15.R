#object orientend system R

#S3,S4,RC,R6

class(1:4)

#this is useful when you can to create a function that can take many different types as argument. Ex. Summary function
#You can pass, lm, matrix, vector, etc and it'll know what summary to use. The acutal summary function doesn't have 
#a bunch of if else to do this it uses object oriented systems 

#way to create new function in summary
summary.catstanding <- function(){}

y<-5:10
class(y)
class(y)<-c("myClass",class(y))

x<-1:10
attr(x,"color")<-"green"

class(x) <-c("colvec",class(x))
y<-nrow(10)
attr(y,"color")<-"darkred"
class(y) <-c("colvec",class(y))

#writing a function to do this
make_colvec <- function(input, color){
  attr(input,"color")<-color
  class(input) <- c("colvec",class(input))
  return(input)
}

#since print is a generic function
print.colvec <- function(x,...){
  stopifnot(is(x,"colvec"))
  cat(paste(attr(x,"color")),": ")
  cat(x)
  invisible(return(x))
} 

get_color <- function(input){
  stopifnot(is(input,"colovec"))
  return(attr(input,"color"))
}

mylist<-list(x=x,y-y,z=z)

colored_boxplot <- function(input,...){
  sapply(input,function(i){
    stopifnot(is(i,c"colvec"))
  })
  colors <- sapply(input,get_color)
  boxplot(x,col=colors,..)
}

numeric_w_digits <- function(x,digits){
  output <- list(numeric=x,
                 digits=digits)
  class(output)<-c("numeric_with_digits",class(output))
  return(output)
}

mwd<-numeric_w_digits((1:5)*pi,3)

print.numeric_w_digits<-function(x,...){
  stopifnot(is(x,"numeric_with_digits"))
  print.default(x[["numeric"]],digits=x[["digits"]])
  invisible(return(x))
}

mwd

#above was using S3, which is very unsafe, b/c very informal. S3 is good for small examples

#s4

setClass("colvec2",
         slots = c(data = "numeric",
                   color = "character"))
x2<-new("colvec2",
        data=1:5,
        color="orange")

colvec2<-setClass("colvec2",
         slots = c(data = "numeric",
                   color = "character"))
y2<-colvec2(data=6:8,
            color="pink")
y2

slot(y2,"color")

#@ sign acts like $
y2@color

setValidity("colvec2",function(input){
  if (!(input@color %in% colors())){
    stop(paste("Color",input@color,"is not a recognized color"))
  }
  return(TRUE)
})

colvec2(1:5,"hotdog")







