clear all                  				// clear old data 
set more off               				// disable the pausing at the bottom of the screen
cap log close                			// close old log in case that there is one 
cd "C:\Users\idank\לימודים\שנה ב\אקונומטריקה\תרגיל 5"          // set the default folder 
log using ps5_log, text replace      	// start the log file here, save as text format and replace old file


/* 
idan keipour 
315355537
EX3
*/

use "WAGE1.dta", clear                // open a Stata data file"


* ans 4)
gen l_wage = log(wage)
reg l_wage educ IQ
reg l_wage educ
reg IQ educ


log close                				// close the log
* everything that comes after the -log close- command WILL NOT show on the log     

