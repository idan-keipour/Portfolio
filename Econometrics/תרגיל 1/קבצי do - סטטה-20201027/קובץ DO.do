clear all                  				// clear old data 
set more off               				// disable the pausing at the bottom of the screen
cap log close                			// close old log in case that there is one 
cd "C:\Users\idank\לימודים\שנה ב\אקונומטריקה\תרגיל 1"          // set the default folder 
log using ps1_log, text replace      	// start the log file here, save as text format and replace old file


/* 
** Introduction to Econometrics 2020
** Problem Set 1

** Yoav Goldstein 	12345678 
** Shahar Lahad		12345678
*/


use "CRIMES.dta", clear                // open a Stata data file named "CRIMES"

* ans number 1)
scatter crimes police 

* ans number 2)
gen crimes_per_capita = crimes/pop

* ans number 3)
gen police_per_capita = police/pop

* ans number 4)
scatter crimes_per_capita police_per_capita 

* ans number 5)
sum crimes_per_capita police_per_capita if west == 1
sum crimes_per_capita police_per_capita if nrtheast == 1
sum crimes_per_capita police_per_capita if south == 1
sum crimes_per_capita police_per_capita if south == 0 & nrtheast == 0 & west == 0 

* ans number 6)
corr  unem crimes_per_capita

*ans number 7)
mean crimes_per_capita if pop<=350000 & year==87
mean crimes_per_capita if pop<=350000 & year==82

*ans number 8)
scatter crimes_per_capita unem if year == 87


log close                				// close the log
* everything that comes after the -log close- command WILL NOT show on the log     

