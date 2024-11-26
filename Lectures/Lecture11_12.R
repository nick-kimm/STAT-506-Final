#Lecture 11

#SQL continued 

library(DBI)
library(RSQLite)

movies <- dbConnect(SQLite(),"/Users/nicholaskim/Documents/STAT 506/HW3/sakila_master.db")

gg<-function(connection,query){
  dbGetQuery(connection,query)
}

gg(movies,"
   SELECT i.film_id
    FROM rental AS r
   LEFT JOIN inventory AS i ON i.inventory_id = r.inventory_id
   LIMIT 5
   ")

#try and do as much inside SQL to run faster queries
#ex. limit over head()

gg(movies,"
    SELECT fa.actor_id, ri.film_id, ri.customer_id
      FROM film_actor as fa
    INNER JOIN(
       SELECT i.film_id, r.customer_id
        FROM rental AS r
       LEFT JOIN inventory AS i ON i.inventory_id = r.inventory_id
   ) AS ri ON ri.film_id = fa.film_id
   ORDER BY ri.film_id, ri.customer_id, fa.actor_id
   LIMIT 50
   ")


#getting first last name 
gg(movies,"
    SELECT COUNT(a.actor_id) AS count, a.first_name, a.last_name
      FROM actor AS a
    RIGHT JOIN (
          SELECT fa.actor_id, ri.film_id, ri.customer_id
            FROM film_actor as fa
          RIGHT JOIN(
             SELECT i.film_id, r.customer_id
              FROM rental AS r
             LEFT JOIN inventory AS i ON i.inventory_id = r.inventory_id
         ) AS ri ON ri.film_id = fa.film_id
         ORDER BY ri.film_id, ri.customer_id, fa.actor_id
         LIMIT 50
    ) AS fari ON fari.actor_id = a.actor_id
   GROUP BY a.actor_id
   ORDER BY -count
   LIMIT 10
   ")

#w/o group by it will collaspe everything into 1 row

##Text manipulation in R

"abc"
"def"

#cat() is saying this is text just dump it out
cat("abd\ndef")

cat("abc\def") #the part after \ is not string in cat. Since \ = escape character

#if you want to print out backslash you have to escape the backslash
cat("I want a backslash: \\")

paste("a","b") #will stick them into one string 
paste(c("a","b")) #won't stick under 1 string since we passed a vector 
paste(c("a","b"),c("d","e"),sep="A")
paste(c("a","b"),c("d","e"),collapse="__")

#nchar() will count how many characters in a string 

substr("agkjkslghejwhjk",3,5)
substr("agkjkslghejwhjk",3,5)<-"asjkkldjsglete" #will truncate replacement to right length

#grep/grepl means search inside 1 string for another string 
#grep returns pos
#grepl returns logicals 

grep("ask","askkjghasjhfsjkahdfs") #first thing you pass is the search term then location 
grepl("ask","askkjghasjhfsjkahdfs")

#these functions are vectorized in their second argument NOT their 1st arg

#if you want to kinda vectorize in the 1st arg
sapply(c("abs","ags"),FUN=grepl,c("agsdfsdf","kjshgjkhsg"))

#%in% is to check membership 
#is x %in% y? 

#sub(), gsub() are functions to find and replace simultaneously 

#sub("art","DOG",artpowers) in artpowers find art and replace with DOG

strsplit("abcd","b") #in the string find b and sepearate into sep string

strsplit("abcd"," ")
strsplit("abcd","") #this will give you every single char

##Regular Expression R

#powers[grepl("q",powers)]

#in R ^pattern$ ^=start of string, $=end of string
#powers[grepl("^q",powers)] find strings that start with q
#powers[grepl("q$",powers)]

#powers[grepl("q[ui]e",powers)] [ui] is match function, replace q to either q or i then follow it by e

#[^] is NOT

#powers[grepl("[aeiou][2]",powers)] want to match anything inside [] by 2 times 
#3 special chars to put after the 1st []
# + means 1 or more
# * means 0 or more 
# ? means 0 or 1

#. means just any character

##Lecture 12

#Capture Group

#grep("[eed]",powers) this will match to these specific char

#grep("(eed|ili)",powers) match to words with eed or ili

#grep("(.)\\1",powers) matches first to any character and then will match whatever you found in the first statement 

#grep("(.)\\1(.)\\2",powers)

#Extracting a pattern 

a<-"NY Mets"
pattern<-"M..s"
grepl(pattern,a)

regout<-regexpr(pattern,a)
asplit<-strsplit(a,"")[[1]]
paste(asplit[regout:(regout=attr(regout,"mathc.length")-1)],collaspe="")

regmatches(a,regout)
regmatches(a,regexpr(pattern,a))

#can also invert the problem. Erase the parts we don't want

a<-c("NY Mets","NY Yankees")

sub("[A-Z]+ ","",a) #this can be difficult especially since we aten't earsing in the context of the pattern we want

sub(".*(M..s).*","\\1",a)

#removes the case where it doesn't occur
sub(".*(M..s).*|.*","\\1",a)


#AIRBNB Ex
grepl("[0-9][1,2][ -]?b(ed|r|d)",boston$name,ignore.case = TRUE)
grepl("[0-9][ -]?(?i)b(ed|r|d(?-i))",boston$name) #same things (?-1) is turn on or off ignore case

regmatches(boston$name,grepl("[0-9][1,2][ -]?b(ed|r|d)",boston$name,ignore.case = TRUE))

##tidyverse
library(stringr)
library(tidyverse)

#idea of piping %>% can use CMD+SHIFT+m on Mac to auto complete

#is same idea as before but a change in the order of things (LEFT to RIGHT) instead on (INNER to OUTER)












