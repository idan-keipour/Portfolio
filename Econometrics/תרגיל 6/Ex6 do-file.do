clear all                  				// clear old data 
set more off               				// disable the pausing at the bottom of the screen
cap log close                			// close old log in case that there is one 
cd "C:\Users\idank\לימודים\שנה ב\אקונומטריקה\תרגיל 6"          // set the default folder 
log using ps6_log, text replace      	// start the log file here, save as text format and replace old file


/* 
idan keipour 
315355537
EX3
*/

use "WAGE1.dta", clear                // open a Stata data file"


* ans 2)
reg lwage educ exper tenure
reg educ tenure exper
gen u_hat = educ - 0.0344348*tenure +0.2384953*exper - 15.97721
reg lwage u_hat

* ans 3)
use "DISCRIM.dta", clear
des prpblck
des income
sum income
sum prpblck

des psoda
reg psoda prpblck income
reg psoda prpblck
gen l_psoda = log(psoda)
gen l_income = log(income)
reg l_psoda prpblck l_income

des prppov
reg l_psoda prpblck l_income prppov

cor l_income prppov





log close                				// close the log
* everything that comes after the -log close- command WILL NOT show on the log     

