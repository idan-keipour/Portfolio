clear all                  				// clear old data 
set more off               				// disable the pausing at the bottom of the screen
cap log close                			// close old log in case that there is one 
cd "C:\Users\idank\לימודים\שנה ב\אקונומטריקה\תרגיל 7"          // set the default folder 
log using ps7_log, text replace      	// start the log file here, save as text format and replace old file


/* 
idan keipour 
315355537
EX7
*/

use "HPRICES.dta", clear                // open a Stata data file"
reg lprice= log(price)

* ans 3)
reg lprice= log(price)
g new = sqrft - 150 * bdrms


log close                				// close the log
* everything that comes after the -log close- command WILL NOT show on the log     

