clear all                  				// clear old data 
set more off               				// disable the pausing at the bottom of the screen
cap log close                			// close old log in case that there is one 
cd "C:\Users\idank\לימודים\שנה ב\אקונומטריקה\תרגיל 8"          // set the default folder 
log using ps8_log, text replace      	// start the log file here, save as text format and replace old file


/* 
idan keipour 
315355537
EX8
*/

use "uk_panel.dta", clear                // open a Stata data file"
count if female ==1
gen sqage=age*age
reg lwage sqage age cog married
reg lwage sqage age cog married london
reg lwage married age sqage cog london i.occ_cat
xtreg lwage sqage age cog married london i.occ_cat, fe i(id)
gen event=year-year_married	
gen s0=event==0
gen s1=event==1
gen s2=event==2
gen s3=event==3
gen s4=event==4
gen s5=event==5
gen s6=event==6
reg lwage sqage age cog london s0 s1 s2 s3 s4 s5 s6

log close                				// close the log
* everything that comes after the -log close- command WILL NOT show on the log     

