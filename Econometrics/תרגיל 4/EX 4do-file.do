clear all                  				// clear old data 
set more off               				// disable the pausing at the bottom of the screen
cap log close                			// close old log in case that there is one 
cd "C:\Users\idank\לימודים\שנה ב\אקונומטריקה\תרגיל 3"          // set the default folder 
log using ps3_log, text replace      	// start the log file here, save as text format and replace old file


/* 
idan keipour 
315355537
EX3
*/

use "HPRICES.dta", clear                // open a Stata data file"


* ans a)
mean price
gen centered_price= price-308363.6
mean sqrft
gen centered_sqrft= sqrft-2114.852


* ans b)
reg price sqrft
reg centered_price centered_sqrft
sum sqrft                //use to check what is the Std. Dev
sum centered_sqrft

* ans c)
twoway (lfit price sqrft) (scatter price sqrft), title(Regress size of house on price)xtitle(size of the house) ytitle(price)

twoway (lfit centered_price centered_sqrft) (scatter centered_price centered_sqrft), title(Regress size of house on price)xtitle(centered size of the house) ytitle(centered price)

* ans d)
gen lprice2 = log(price * 1000)
reg lprice sqrft
reg lprice2 sqrft 
twoway (lfit lprice sqrft) (scatter lprice sqrft), title(Regress size of house on price)xtitle(size of the house) ytitle(price)
twoway (lfit lprice2 sqrft) (scatter lprice2 sqrft), title(Regress size of house on price)xtitle(size of the house) ytitle(price)

log close                				// close the log
* everything that comes after the -log close- command WILL NOT show on the log     

