clear all                  				// clear old data 
set more off               				// disable the pausing at the bottom of the screen
cap log close                			// close old log in case that there is one 
cd "C:\Users\idank\לימודים\שנה ב\אקונומטריקה\תרגיל 9"          // set the default folder 
log using ps9_log, text replace      	// start the log file here, save as text format and replace old file


/* 
idan keipour 
315355537
EX9
*/

use "affairs", clear                // open a Stata data file"
des
reg affair male age yrsmarr kids educ vryhap hapavg avgmarr unhap vryrel smerel slghtrel notrel, robust
margins, dydx(age) at(age=(17(10)57))

probit affair male age yrsmarr kids educ vryhap hapavg avgmarr unhap vryrel smerel slghtrel notrel, robust
margins, dydx(*) post atmeans
probit affair male age yrsmarr kids educ vryhap hapavg avgmarr unhap vryrel smerel slghtrel notrel, robust
margins, dydx(age) at(age=(17(10)57))
marginsplot

logit affair male age yrsmarr kids educ vryhap hapavg avgmarr unhap vryrel smerel slghtrel notrel, robust
margins, dydx(*) post atmeans
logit affair male age yrsmarr kids educ vryhap hapavg avgmarr unhap vryrel smerel slghtrel notrel, robust
margins, dydx(age) at(age=(17(10)57))
marginsplot


log close                				// close the log
* everything that comes after the -log close- command WILL NOT show on the log     

