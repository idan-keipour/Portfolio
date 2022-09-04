clear all                  				// clear old data 
set more off               				// disable the pausing at the bottom of the screen
cap log close                			// close old log in case that there is one 
cd "C:\Users\idank\לימודים\שנה ב\אקונומטריקה\תרגיל 2"          // set the default folder 
log using ps2_log, text replace      	// start the log file here, save as text format and replace old file


/* 
idan keipour 
315355537
EX2
*/


use "ATTEND_2020.dta", clear                // open a Stata data file"
use "BWGHT2_2020.dta", clear


* ans number 1)
count
sum cigs if cigs>0
sum drink
tab monpre
reg bwght cigs

use "ATTEND_2020.dta", clear

* ans number 2)
sum ACT
sum atndrte
reg atndrte ACT
predict a
sum a


log close                				// close the log
* everything that comes after the -log close- command WILL NOT show on the log     

