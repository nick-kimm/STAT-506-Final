#How to automatically pool models w/ n number of categorical var and return model and se
#you could do this by changing the reference value 
data(mtcars)

table(mtcars$gear)
mtcars$gear <- as.factor(mtcars$gear)

mod <- lm(mpg~gear+hp,data=mtcars)
summary(mod)

library(multcomp)
#All models on own:
summary(glht(mod,"(Intercept)+hp=0"))
summary(glht(mod,"(Intercept)+gear4+hp=0"))
summary(glht(mod,"(Intercept)+gear5+hp=0"))

summary(glht(mod,"gear4=0")) #you need to set it equal to some constant
summary(glht(mod,"gear5=0"))
summary(glht(mod,"gear4-gear5=0"))

#Can see that the equations would get quickly out of hand with more categories. How to do it auto

#this linear hypo testing can be used in both continious variables as well. Doesn't just have to be for cat var

#the auto trick is marginals
library(emmeans)

emmeans(mod,~gear) #these values are slightly diff then from summary output above because of hp
#emmeans will auto take hp at its mean while one above is setting hp by itself

#one part where it doesn't change is in the difference in means
pairs(emmeans(mod,~gear))
#the one above is readjusting how to display r summary so some argue its not a different model
pairs(emmeans(mod,~gear),adjust="none")
#this will run diff tests

#other packages that have similar effect
library(marginaleffects)
library(ggeffects)

#INTERACTIONS
#used when we think the result of y changes depending on what group it is in

mod3 <- lm(mpg~gear*hp,data=mtcars)
summary(mod3)

summary(glht(mod3,"hp=0"))
summary(glht(mod3,"hp+gear4:hp=0"))
summary(glht(mod3,"hp+gear5:hp=0"))

summary(glht(mod3,"gear4:hp=0"))
summary(glht(mod3,"gear5:hp=0"))
summary(glht(mod3,"gear4:hp+gear5:hp=0"))

#can try and estimate the intercepts of these model but that can be difficult and take time. 
#So how bout we plot it instead. This is called an interaction plot

emmip(mod3,gear~hp,at=list(hp=c(100,150,200,250)))

library(interactions)
interact_plot(mod3,pred="hp",modx="gear")

#glm
#linear model with a linked function 
#ex.taking log of the function y if y takes values in (0,1)

mod4<-glm(am~gear*hp,data=mtcars,family = binomial)
summary(mod4)

#mixed effects models 
#will apply where not all data is independent of each other 
#each var will have it own intercept
library(lme4)
library(lmerTest)

head(InstEval)

mod5 <- lmer(y~service+(1|s),data=InstEval)
summary(mod5)

head(predict(mod5))

#SQL
#this is powerful because you can filter to get the dataset you want to answer your specific question 

#the most common one is sqllight but there are many flavors of sql

library(DBI) #why to interact with the SQL server and with R
library(RSQLite)

dbConnect(SQLite(),"....") #first is what kind of SQL ver are we using, second is where it the data located (mostly a server loc)
#SQL is not actually loading the real database in your computer but intead is establishing a connection which then you'll run queries

dbListTables(data)
dbListFields(data,"People") #are all the var names in the table People

dbGetQuery(data,"SELECT playerID FROM people LIMIT 6")

#query: entire string
# statement: "SELECT _"
# clauses: ex "FROM _", "LIMIT _", etc.

gg <- function(connection,query){
  dbGetQuery(connection,query)
}

#this function just so you don't have to rewrite the long function name every time

#the key words are generally in CAPS, other lower

#also try to put clause in sep lines to make it more readable 
gg("
SELECT * 
   FROM people 
   LIMIT 5
   ")

#common way to count num rows

gg("
   SELECT COUNT(playerid)
   FROM halloffame
   ")

#when you do count it will actually collapse the table down to just the count value

gg("
   SELECT COUNT(playerid)
   FROM halloffame
   WHERE (yearid > 2004 AND yearid < 2010) OR yearid > 2015
   ")

table<-gg("
   SELECT COUNT(playerid)
   FROM halloffame
   ")

nrow(table[(table$yearid>2004 & table$yearid<2010)| table$yearid > 2015])

dbListFields(laham,"people")

gg("
   SELECT COUNT(namesFirst)
   FROM people
   WHERE nameLast = 'Griffey' OR nameLast = 'Aaron'
   ")

#can't use "" inside "" but can use '' inside ""
#single = is the same as == (stick to using = in SQL)

gg("
   SELECT COUNT(namesFirst)
   FROM people
   WHERE nameLast IN ('Griffey','Aaron')
   ")

gg("
   SELECT nameLast
   FROM people
   WHERE nameLast LIKE '%iff%'
   LIMT 5
   ")

#can use %% as while this is true

gg("
   SELECT playerid, hr
   FROM batting 
   WHERE hr>10
   ORDER BY -HR
   LIMIT 10
   ")
#ORDER BY defaults by ascending, - makes it descending 

gg("
   SELECT playerid AS name, SUM(hr) AS sum_hr
   FROM Batting
   WHERE yearid > 2010
   GROUP BY playerid
   HAVING sum_hr > 340
   ORDER BY -sum_hr
   LIMIT 5
   ")

#SQL can't really look at it piece by piece put holistically

#WHERE can only work on preexisting names, HAVING related to the calculated variables 

#JOIN functions 

#INNER JOIN combines only when your in both groups 
#LEFT JOIN, RIGHT JOIN, pull only rows that are in the existing table
#OUTER JOIN pull in everybody

#the batting dataset doens't have player names but it might be nice to. Lets use join function 


gg("
   SELECT playerid, SUM(hr) AS sum_hr
   FROM Batting
   WHERE yearid > 2010
   GROUP BY playerid
   ORDER BY -sum_hr
   LIMIT 5
   ")

gg("
   SELECT playerid, nameFirst, nameLast
   FROM people
   LIMIT 5
   ")

#BASE EX of INNER JOIN
gg("
   SELECT b.playerid, b.hr, p.nameLast
   FROM batting AS b
   INNER JOIN people AS p ON b.playerid = p.playerid
   LIMIT 5
   ")

#back to initial ex

gg("
   SELECT p.playerid, SUM(b.hr) AS sum_hr
      FROM Batting AS b
   INNER JOIN 
           (SELECT playerid, nameFirst, nameLast
              FROM people) AS p
              ON b.playerid = p.playerid
   WHERE yearid > 2010
   GROUP BY p.playerid
   ORDER BY -sum_hr
   LIMIT 5
   ")

#What schools have produced the most ROY 

gg("
   SELECT playerid, schoolid, MAX(yearID) AS lastyr
      FROM collegeplaying
    GROUP BY playerid
    LIMIT 10
   ")

#the groupby will default to 1st row

gg("
   SELECT *
      FROM collegeplaying
    GROUP BY playerid
    HAVING yearid = MAX(yearid)
    LIMIT 10
   ")

#looking at all unique awards in the data
gg("
   SELECT DISTINCT(playerid)
      FROM awardplayers
   ")

#playerid with just ROYs
gg("
   SELECT playerid, awardid
      FROM awardplayers
    WHERE awardid LIKE 'Rookie%'
    LIMIT 5
   ")

#joining two tables
#this will give all playerid and the school they graduated from 
gg("
   SELECT a.playerid, c.schoolid
      FROM collegeplaying AS c
      LEFT JOIN (
          SELECT playerid, awardid
            FROM awardplayers
           WHERE awardid LIKE 'Rookie%'
           ) AS a ON a.playerid = c.playerid
    GROUP BY a.playerid
    HAVING c.yearid = MAX(yearid)
    LIMIT 10
   ")

#this will count the number of players from said school 

gg("
   SELECT count(schoolID) AS count 
      FROM (SELECT a.playerid, c.schoolid
              FROM collegeplaying AS c
              LEFT JOIN (
                    SELECT playerid, awardid
                      FROM awardplayers
                    WHERE awardid LIKE 'Rookie%'
                    ) AS a ON a.playerid = c.playerid
              GROUP BY a.playerid
              HAVING c.yearid = MAX(yearid))
   GROUP BY schoolID
   ORDER BY -count
   LIMIT 5
   ")

#Order of Clauses: (very imp)

#SELECT
#FROM
#JOIN
#WHERE
#GROUP BY
#HAVING
#ORDER BY
#LIMIT










