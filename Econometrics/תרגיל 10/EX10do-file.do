clear all                  				// clear old data 
set more off               				// disable the pausing at the bottom of the screen
cap log close                			// close old log in case that there is one 
cd "C:\Users\idank\לימודים\שנה ב\אקונומטריקה\תרגיל 10"          // set the default folder 
log using ps10_log, text replace      	// start the log file here, save as text format and replace old file


/* 
Idan Keipour and Menachem Sokolik
315355537 314696972
EX10
*/

use "Fertility", clear                // open a Stata data file"
des
sum agem1
sum weeksm1
count if weeksm1 == 0
mean weeksm1 if weeksm1>0
count if morekids
count if samesex
reg weeksm1 morekids agem1 black hispan othrace
reg morekids samesex agem1 black hispan othrace
predict morekids_predict
reg weeksm1 morekids_predict agem1 black hispan othrace , robust
ivregress 2sls weeksm1 (morekids=samesex) agem1 black hispan othrace , robust



 
log close                				// close the log
* everything that comes after the -log close- command WILL NOT show on the log     

