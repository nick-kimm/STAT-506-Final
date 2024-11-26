#Lecture 1

#object oriented programming language: everything in R is an object/variable
#<- or = gets, [1] = vector length is 1
#c() = concatenate, combines the vectors together

#try and use <- over = b/c it can cause problems
#for assignment use <- 
#for passing arguments use =

#try to follow a code style: such as using <- over =
#to make it easier to read for other people

#Ex: stay consistent w/ one of these styles for variable names
#ndis
#nDis
#n_dis
#n.dis NEVER USE THIS

#value copy, so if you do b = a it is not linking these two variables but will take a 
#copy of a and assigning to b so if a changes b will stay the same unless reassigned to a

#ls() a function that is lisitng all the current variables in the global environment
#rm() removes variables from the global environment 
#assign(,) assigns x to y

assign("a","myVar")
a
assign(a,4)
myVar
get(a)

#it sees the string myVar and it assigns the a to the new term 4

#%% mod or remainder
#% % division

a <- c(4)
b <- c(2,6)
a+b #vector length 2 w/ 4 added to all values in b

c <- c(1, 500)
d <- c(2, 6, 1, 0)
c+d #does recycling and adds 1 to 2 then 500 to 6 and so on

#when reading nested functions go from inside out 
#imp to have the right dimensions (vectorized function or not)

sqrt(2)^2 - 2 #the output won't actually be zero but will be an extremely small number b/c the bound is very big

#== comparison

sqrt(2)^2 == 2 #output is FALSE b/c of the large bound issue as noted above
all.equal(sqrt(2)^2, 2) #will handled the large bound issue 
all.equal(sqrt(2)^2, 3) == TRUE

#existing constants: don't override
#pi, T
#don't want to reassign T and then try a comparison w/ T it won't work as expected

#PACKAGES
#cran: is a website where you can find and load packages, has been quality controlled in that code will run w/ it loaded
#bioconductor: is another website to find and load packages
#github: raw code so no guarantees it'll run if installed
#R comes w/ base packages

#library(_) using a package in your code
#install.packages("") install a package into your library

#:: look inside some package and find _ object/function, use this if you want to write your own package & remove dependency 
#::: look inside some package for internal program that isn't an exported version that is seen in ::
#ex. lme4::instaEval

#search() list of all the environments in R
#if you load a package it'll create a new sub environment w/ the most recent installed package to the top of the stack

##QUARTO
# use this for your hw assignments, sumbit qmd file on github, and the output doc will be sumbited on Canvas
#switch over to quarto over rmarkdown
#disable visual markdown editor when creating a quarto doc

# the ## = header 
# ** ** = bold 
# [text](http...) = link under text

# '''{r or python} 
#                   = will run code in this section
# ''' 

#'''r 
#     = will format link r code but won't run 
# '''

#when don't want to show a bunch of lines of code in the markdown but still needed to run use: # echo: false

#variables will stay "stored" if you define x in one chunk can still refer to it in another 

#render will run on a completely fresh version of R so the console may not be up to date with the varaibles in Quarto doc

# ' ' will look like code and can extract things for ease of readibility 

#format:
#   html:
#       toc: true = will create a table of contents

# the : is creating options 

#if you want more than 1 format then need to set one of the options as 'default'
#ex. html:
#    pdf: default

##VERSION CONTROL
#every time you make a change it'll make a backup copy
#can make it easier to merge together to files say when two people are working on the same section 

#git is a version control tool, github is not git (is a git repository)

#will save diff of what changes from the previous doc

#Clone: will recreate a version to your local machine
#Modify: will make changes to the file if you want to in your local machine 
#Add: the changes will be added to the file 
#Commit: the changes to your local repository
#Push: the new changes from your local repository to the remote repository 

#set up of github to local
#use SSH link after creating a repository 
#new project and use version control -> git -> paste the link -> put in file you want

#git tab -> commit -> is showing you diffs -> clicking boxes will added the changes to the file -> everytime you commit you should add an informative message
#click commit -> will implement the changes -> these will implement the changes locally NOT to your github 

#if you want to push to github hit: push

#commit. often and commit small. This way you can go back and see what breaks and your line of thinking when implementing the change

#clock icon is history: storing all your gits. 

##R NOTES CONT

#getwd() = gets you what the current working directory is 
#setwd("/desktop/...") will get the working directory to __, for best practice set this as one of your first line of code

#data() function that'll load in built in datasets

#when using readRDS, and saveRDS you need to assign it to some object since it is saving and loading the ouput of something
#for save and load you don't need to assign since it's saving object name and output

























