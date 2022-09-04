

* COMMANDS TO CLEAR THE SYSTEM AND START A "DO" FILE

clear all          /* clear the working data set              */
set more off       /* sets it to run continously, without pressing the "space" bar  */
cap log close      /* closes the log file in case one is opened                   */

* SET WORKING DIRECTORY
cd "C:\Users\Shahar\Google Drive\Econometrics Class\Problem Sets\PS1"

* OPEN A LOG FILE (FOR THE RESULTS) WITH A NAME: "intr_eco_1", replacing any existing file by the same name 

log using "intr_eco_1", text replace


/* 
	---------------------------------
	Introduction to Econometrics 2020
			Welcome to Stata
	---------------------------------
*/



* OPEN THE STATA DATA FILE "WAGE.dta"
use "WAGE1.dta", clear


*  USE THE "BROWSE" COMMAND TO SEE THE DATA (the new variables, the way it is sorted, etc)
browse


* DESCRIBE THE DATA SET
describe


* LOOK AT SUMMARY STATISTICS (Means and Variances)OF ALL VARIABLES IN THE CURRENT WORKING DATA SET USING -SUMMARIZE-
summarize


* LOOK AT SUMMARY STATISTICS FOR CERTAIN VARIALBES 
sum wage hours


*  DO THE SAME THING FOR EACH YEAR, FIRST YOU NEED TO SORT THE DATA BY YEAR 
sort married
by married: sum educ IQ


* AGAIN - IN A SINGLE LINE USING -bysort-
bysort married: sum educ IQ
 

* LIST THE VALUES OF A VARIABLE AND ITS FREQUENCIES	
tab sibs


* DROP CERTAIN VARIABLES THAT YOU DO NOT NEED IN THIS SESSION
drop lwage KWW brthord


* CREATE SOME NEW VARIABLES USING THE -GENERATE- COMMAND
generate lwage = ln(wage)
gen wage_per_hour = wage/hours 

* REPLACE VALUES USING -replace- AND -if- CONDITION
g high_IQ = 0
replace high_IQ = 1 if IQ >= 130

sum IQ if married == 1
sum IQ if married != 0



*  USE THE "HELP" COMMAND: FOR EXAMPLE, TO SEE ALL DETAILS ABOUT THE "SUMMARIZE" COMMAND 
*  NOTE: STATA IS FRIENDLY IN TERMS OF THE HELP
help generate
		// you could also google: "stata how to create new variable"

		
* SAVE THE DATA FILE AS A STATA DATA SET (called "my_file.dta"), replacing existing data set with that name if it already exists
save "my_file.dta", replace


* OPEN THE STATA DATA FILE "my_file.dta"
use "my_file.dta"
// might not work

* REPLACE THE CURRENT DATA FILE WITH "my_file.dta"
use "my_file.dta", clear



* COMPUTE THE CORRELATION BETWEEN VARIABLES
corr sibs IQ educ

* CREATE A SIMPLE SCATTER GRAPH
scatter wage IQ

* SAVE IT AS "wage_iq_scatter.png" (REPLACING EXISTING GRAPH FILE WITH THAT NAME IF IT ALREADY EXISTS)
graph export  wage_iq_scatter.png, replace



* CLOSE THE LOG FILE
log close

