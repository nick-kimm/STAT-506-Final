#for if else 
if (3<2) a <- 4
#this will run w/o error but don't do this, use {} or closure brackets

a <- is (3<2){
  4
} else{
  6
}

#can do assignment outside of the if else statement

ifelse(3<2,4,6) #is a function to succinctly write the if else statement 

sum(c(4,9,6))

#vectorization is it'll take a number of objects and doing something w/ it
#it is also very fast behind the scenes

x <- c(5,2,6,1,7,8,8)
s0 = 0

for (i in 1:length(x)){
  s0 = s0 + x[i]
}

s0

mysum <- function(x){
  #input sanitize here
  s0 <- 0
  for (i in 1:length(x)){
    s0 = s0 + x[i]
  }
  return(s0)
}

mysum(x)

system.time(mysum(x))

library(microbenchmark)

z <- 1:1000000
microbenchmark(mysum(z),sum(z))

#can see that vectors are much faster
#b/c vectorization avoids reassignment and the function is not in R but uses C which is lower level and much faster 

l<-list(c(1,2,3),c(1),c(1:10))
length(l)
sapply(l,length) 

apply()

m <- matrix(c(2,3,4,1,4,5,6,8),nrow=4)
mean(m[,1])

apply(m,MARGIN = 2,mean) #MARGIN = 2 (column), = 1 (row)

#ex of using ...

m <- matrix(c(2,3,4,1,-4,5,NA,8),nrow=4)

apply(m,MARGIN = 2,mean)
apply(m,MARGIN = 2,mean,na.rm=TRUE)

apply(abs(m),2,mean,na.rm=TRUE)

abs_and_mean <- function(k,na.rm=FALSE){
  mean(abs(k),na.rm=na.rm)
}

apply(m,2,abs_and_mean,na.rm=TRUE)

apply(m,2,function(k,na.rm=TRUE){
  mean(abs(k),na.rm=na.rm)
})

#this is called anonymous function as its not storing the function we created 

apply(m,2,\(k,na.rm=TRUE){
  mean(abs(k),na.rm=na.rm)
})
#the \ will also create an anonymous func

#apply will also work in 3D: apply(m,3,mean)
#apply only works on rectangular datasets, for lists we use lapply, sapply, vapply

lapply(l,length) #returns a list
sapply(l,length) #will return a simplier dataset, in this case gives a vector 

l2 <- list(matrix(1:4,nrow=2),matrix(1:6,nrow=3),array(1:8,dim=c(2,2,2)))
lapply(l2,dim)
sapply(l2,dim) #if it can't reduce it'll keep it as original data structure 
#this is dangerous b/c you could get a vector and then compare it/use it against a more complicated data structure 

#for vapply we need to input an example of what we expect the result to look like. Makes it even safer that lapply

vapply(l2,mean,1)
vapply(l2,is.numeric,TRUE)

index <- c(1,2)
price <- list(3:1,1:5)

mapply(function(x,i){
  x[index]
},price,index)

#quick way to split by group 
data(iris)
tapply(iris$Petal.Length,iris$Species,mean)

#apply function are NOT vectorized 
#they are "loop hiding" uses a loop but can't see it 

##How do you write a vectorized code? 
#use the vectorized functions that are built into R in your code

negabs1 <- function(x){
  if (x<=0){
    return(x)
  }
  if (x>0){
    return(-x)
  }
}

negabs1(-10000)


negabs2 <- function(x){
  out <- c()
  for (i in 1:length(x)){
    out <- c(out,if(x[i]<=0){
      x[i] 
    }else{
      -x[i]
    })
  }
  return(out)
}

negabs2(c(-1000,2,9))

#the better approach (below) as more efficient

negabs3 <- function(x){
  out <- vector(length=length(x))
  for (i in 1:length(x)){
    out[i] <- if(x[i]<=0){
      x[i] 
    }else{
      -x[i]
    }
  }
  return(out)
}

negabs3(c(-1000,2,9))

negabs4 <- function(x){
  -abs(x)
}

microbenchmark(negabs2(-500:500),
               negabs3(-500:500),
               negabs4(-500:500))

sample(5:73,10,replace=TRUE)

sample(c(0,1),10,replace=TRUE)

#will make it so your randomness will get set so you'll get repeatable results
set.seed(0)
sample(c(0,1),10,replace=TRUE)

#don't put seed until you need to publish/show results to others 
#b/c the set seed could be of the extreme case, that is not as useful/will give you results that are skewed

#ex. simple monte carlo sim or estimating pi through area of square and circle

x <- runif(1,-1, 1) #give me 1 value (the x-cord) b/t -1 and 1

y <- runif(1,-1,1)

sqrt(x^2+y^2) <= -1 # this wil check to see if your point is inside the circle 

est_pi <- function(n){
  xcords <- runif(n,-1,1)
  ycords <- runif(n,-1,1)
  in_circle <- (sqrt(xcords^2+ycords^2)) <= 1 
  return(4*sum(in_circle)/n)
}

est_pi(100000)

#Sim for quantiles in Z-scores

n <- 10000
df <- 3

dat <- rt(n,df)
hist(dat)

#1.96, -1.96
save <- vector(length=n)

for (i in 1:n){
  save[i] <- dat[i]<-1.96
}

c(mean(dat<-1.96),mean(dat>1.96))

odat<-dat[order(dat)]
order(c(4,2,7)) #tells what the order of the values are lowest to highest

head(dat,n=20)
head(odat,n=20)

odat[round(.025*n)]
odat[round(.975*n)]

reps <- 10000 #1,000s-10,000 is rel low/bare min for sim
n <- 25
df <-300

sims <- rt(reps*n,df=df)
msims <- matrix(sims,nrow=n)
msims[,1:3] #one column is a dataset

means <- apply(msims, 2, mean)
ses <- apply(msims, 2, sd)/sqrt(n)
crit <- abs(qt(.025, df))

lb <- means - crit*ses
up <- means + crit*ses

#vectors in R don't have dimensions unless specified in matrix 

cov<- lb < 0 & up > 0 #&& compares one object to another 
mean(cov)

#bootstrapping: taking random samples from one dataset to create many data to do analysis on 

#is recycling 
c(1) + c(2,3,4) 
c(1,2) + c(2,3,4,5)
c(1,2) + c(5,6,7)

m <- matrix(1:8,nrow=2)
m+1 #this won't and will recycle 1 to all elements
m+matrix(1) #this will yell at you

m+c(1,10) #since in R Matrix are col dom recycling will also follows in the same logic\
m+c(1,10,-10,20)

mmeans <- apply(m,2,mean)
m-mmeans

#this is to do means over column 
mmeans
rep(mmeans,each=nrow(m))
m-rep(mmeans,each=2)

#better appraoch is to transpose the m and then use apply
t(t(m)-mmeans)

m
t(t(m)-rowMeans(t(m))) #little faster than apply

library(microbenchmark)

microbenchmark(
t(t(m) - apply(m,2,mean)),
t(t(m) - rowMeans(t(m)))
)

microbenchmark(
  apply = apply(m,2,mean),
  rowMeans(m)
)

n<-50
m<-200
r<-.5

y<-rnorm(n)
xhat<-matrix(rep(y,times=m),nrow=n)

rep(1:3,each=3)
rep(1:3,times=3)

xhat<- r*xhat + rnorm(n*m,sd=sqrt(1-r^2))

cor(y,xhat[,4])

#to get cor for every col
#naive:
cor(y,xhat)


mb1<-microbenchmark(
  v1={
    somevec<-vector(length=m)
    for(i in 1:m){
      somevec[i]<-cor(y,xhat[,i])
    }
}
)
mean(somevec1)

mb2<-microbenchmark(
  v2={
    somevec2<-apply(xhat,2,function(k){cor(y,k)})
  }
)
mean(somevec2)

#ctrl + i to retab everything auto
mb3<-microbenchmark(
  v3={
    xm <- colMeans(xhat)
    xsd <- apply(chat,2,sd)
    
    xmat2 <- xhat - matrix(rep(xm,each=n),nrow=n)
    xmat3 <- xmat2/matrix(rep(xsd,each=n),nrow=n)
    
    #try and rename for storing data to help with debugging, saving previous object
    
    yz<-(y-mean(y))/sd(y)
    somevec3 <- as.vector((yz %*% xmat3)/(n-1)) #%*% is matrix multi
  }
)
mean(somevec3)

#fastest approach

mb4 <- microbenchmark(
  v4={
    xm <- colMeans(xhat)
    xmat2 <- t(t(xmat)-xm)
    xsd <- sqrt(colSums(xmat2^2)/(n-1))
    xmat3 <- t(t(xmat2)/xsd)
    yz<-(y-mean(y))/sd(y)
    somevec4 <- as.vector((yz %*% xmat3)/(n-1))
  }
)
mean(somevec4)

rbind(mb1,mb2,mb3,mb4)

#the reason naive is worse is not just speed but space, naive would create a n by b matrix while better appraoch is a n by 1

#profiling: line by line to see can this line be written faster 

#can also use everything as a function as functions in R are used as objects

#going back to the coverage sim if we want to try a different distribution would have to manually change the dis to whatever dis we want

reps <- 10000 #1,000s-10,000 is rel low/bare min for sim
n <- 25
df <-300

coveragesim <- function(reps,n,dis,...){
  sims <- dis(reps*n,...)
  msims <- matrix(sims,nrow=n)
  msims[,1:3] #one column is a dataset
  
  means <- apply(msims, 2, mean)
  ses <- apply(msims, 2, sd)/sqrt(n)
  crit <- abs(qt(.025, df))
  
  lb <- means - crit*ses
  up <- means + crit*ses
  
  #vectors in R don't have dimensions unless specified in matrix 
  
  cov<- lb < 0 & up > 0 #&& compares one object to another 
  return(mean(cov))
}
coveragesim(reps,n,dis=rt,df=df)
coveragesim(reps,n,dis=rgamma,shape=3,rate=1/2)









