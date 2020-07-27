

global path "C:\Users\mweinhardt\repos\closeddoors\"


***Germany 1

clear

import delimited $path\data\Germany1.csv, delimiter(";") encoding(utf8) 
save c:\temp\Germany1.dta, replace

replace outcome="1" if outcome=="Home win"
replace outcome="2" if outcome=="Draw"
replace outcome="3" if outcome=="Away win"
destring outcome, replace
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=224; Games without supporters: N=82)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\Germany1.png, replace


***Germany 2

clear

import delimited $path\data\Germany2.csv, delimiter(";") encoding(utf8) 
save c:\temp\Germany2.dta, replace

replace outcome="1" if outcome=="Home win"
replace outcome="2" if outcome=="Draw"
replace outcome="3" if outcome=="Away win"
destring outcome, replace
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=225; Games without supporters: N=81)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\Germany2.png, replace

***Germany 3

clear

import delimited $path\data\Germany3.csv, delimiter(";") encoding(utf8) 
save c:\temp\Germany3.dta, replace

replace outcome="1" if outcome=="Home win"
replace outcome="2" if outcome=="Draw"
replace outcome="3" if outcome=="Away win"
destring outcome, replace
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=270; Games without supporters: N=110)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\Germany3.png, replace


***Spain 1

clear

import delimited $path\data\Spain1.csv, delimiter(";") encoding(utf8) 
save c:\temp\Spain1.dta, replace

replace outcome="1" if outcome=="Home win"
replace outcome="2" if outcome=="Draw"
replace outcome="3" if outcome=="Away win"
destring outcome, replace
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=270; Games without supporters: N=110)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\Spain1.png, replace


***Poland 1

clear

import delimited $path\data\Poland1.csv, delimiter(";") encoding(utf8) 
save c:\temp\Poland1.dta, replace

replace outcome="1" if outcome=="Home win"
replace outcome="2" if outcome=="Draw"
replace outcome="3" if outcome=="Away win"
destring outcome, replace
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=208; Games without supporters: N=88)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\Poland1.png, replace


***England 1

clear

import delimited $path\data\England1.csv, delimiter(";") encoding(utf8) 
save c:\temp\England1.dta, replace

replace outcome="1" if outcome=="Home win"
replace outcome="2" if outcome=="Draw"
replace outcome="3" if outcome=="Away win"
destring outcome, replace
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=288; Games without supporters: N=92)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\England1.png, replace


***England 2

clear

import delimited $path\data\England2.csv, delimiter(";") encoding(utf8) 
save c:\temp\England2.dta, replace

replace outcome="1" if outcome=="Home win"
replace outcome="2" if outcome=="Draw"
replace outcome="3" if outcome=="Away win"
destring outcome, replace
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=444; Games without supporters: N=108)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\England2.png, replace

***Portugal 1

clear

import delimited $path\data\Portugal1.csv, delimiter(";") encoding(utf8) 
save c:\temp\Portugal1.dta, replace

replace outcome="1" if outcome=="Home win"
replace outcome="2" if outcome=="Draw"
replace outcome="3" if outcome=="Away win"
destring outcome, replace
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=216; Games without supporters: N=90)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\Portugal1.png, replace

********************+
cd c:\temp\
use Germany1.dta, clear
append using Germany2 Germany3 England1 England2 Poland1 Portugal1 Spain1, generate(league)
d,s

replace outcome="1" if outcome=="Home win"
replace outcome="2" if outcome=="Draw"
replace outcome="3" if outcome=="Away win"
destring outcome, replace
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=2145; Games without supporters: N=761)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 
graph export $path\all.png, replace
