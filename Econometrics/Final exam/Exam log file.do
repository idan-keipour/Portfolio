clear all                  				// clear old data 
set more off               				// disable the pausing at the bottom of the screen
cap log close                			// close old log in case that there is one 
cd "C:\Users\idank\לימודים\שנה ב\אקונומטריקה\מבחן בית"          // set the default folder 
log using Final_Exam, text replace      	// start the log file here, save as text format and replace old file

/* 
idan keipour 
315355537
Final Exam
*/
use "ukdata_new", clear

//To check which variables contain missing values
count if educ==-999  
count if married==-999
count if bornuk==-999
count if female==-999
count if age==-999
count if wage==-999
count if year==-999
count if id==-999
count if firmsize==-999
replace firmsize=. if firmsize==-999

//question 1
count if age==50 & female==1 & educ==3
count if age==50 & female==1
// the answer is 116/406
//question 2
count if age==50 & female==0 & educ==3
count if age==50 & female==0
// the answer is 81/313

//question 3
/* The calculation is this:
n1=406
n2=313
p1=116/406
p2=81/313
all_prop= ((n1)/(n1+n2))*p1+((n2)/(n1+n2))*p2
denominator=math.sqrt(((all_prop*(1-all_prop))/n1)+((all_prop*(1-all_prop))/n2))
t=((p1-p2)/denominator)= 0.80267715
*/
//question 4
drop if age<20 
drop if age>65
drop if female==0 

gen lwage=log(wage)
gen age2=age*age
gen hsg=1 if educ==2
replace hsg=0 if educ!=2
//model 1
reg lwage age educ
//model 2
reg lwage age educ age2
//model 3 
reg lwage age educ age2 hsg	
test educ hsg //Education consists of these two variables and therefore needs an F-test
//question 7: 0.3089981-0.2121023 = 0.0968958
//question 8: (3-1)*0.3089981 = 0.6179962

//model 4 (question 9+10)
reg lwage age educ age2 hsg married
reg lwage age educ age2 hsg married id
//model 5
xtreg lwage age age2 educ hsg married, fe i(id)
// model 6 question 12
xtreg lwage age age2 educ hsg married i.firmsize, fe i(id)
/*question 13: If the company until a moment ago had 30 employees and they fired 10 employees - the salaries of existing employees remain the same.
Therefore the calculation is according to a company of 30
*/
/*question 15
Remember we look at the same person over time. The hsg variable already contains
the possibility that educ = 2 and in addition we see that it is negative and educ positive. 
Therefore it must be that at least one person completed a degree during the experiment in order for us to get the estimate for educ.
*/
//question 17
gen yearuk = year*bornuk 
xtreg lwage age age2 educ hsg married yearuk, fe i(id)


//question 25
/*I calculated the normal probability for two packs of cigarettes (and the average values ​​of the other variables) 
and subtracted the normal probability for one pack of cigarettes (and the average values ​​of the other variables)
(-0.1253025-0.2926817*0.5208934-0.4430008*0.7845821-0.0074411*12.93583+0.5835045*2) =~ 0.4
(-0.1253025-0.2926817*0.5208934-0.4430008*0.7845821-0.0074411*12.93583+0.5835045) =~ (-0.1)
Φ(0.4)-Φ(-0.1) = 0.6554217-0.4601722=0.1952495
*/

log close                				// close the log
* everything that comes after the -log close- command WILL NOT show on the log     

