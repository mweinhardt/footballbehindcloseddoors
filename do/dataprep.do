

import delimited C:\Users\micha\Documents\Projekte\3_presentations\ESA2021\soccer-spi\soccer-spi\spi_matches.csv, clear

save "C:\Users\micha\Documents\Projekte\3_presentations\ESA2021\data\538_soccer_spi.dta", replace

***
use "C:\Users\micha\Documents\repos\closeddoors\data\538_soccer_spi.dta", clear

tab1 season league

drop if league=="UEFA Champions League"
drop if league=="UEFA Europa League"
drop if league=="Argentina Primera Division"
drop if league=="Brasileiro SÃ©rie A"
drop if league=="FA Women's Super League"
drop if league=="Major League Soccer"
drop if league=="Mexican Primera Division Torneo Apertura"
drop if league=="Mexican Primera Division Torneo Clausura"
drop if league=="National Women's Soccer League"
drop if league=="Russian Premier Liga"
drop if league=="Swedish Allsvenskan"
drop if league=="Norwegian Tippeligaen"

drop if season==2021
drop if season==2016

bysort league: egen minseason=min(season)
tab minseason

drop if minseason>2017

drop if score1==.

split date, parse("-")
rename date1 year
rename date2 month
rename date3 day
destring year month day, replace

egen monthcount=group(year month)
tab monthcount

gen ghostgames=0
replace ghostgames=1 if year>2020 | (year==2020 & month>3) | (year==2020 & month==3 & day>19)
tab ghostgames

replace league="English Premier League" if league=="Barclays Premier League"
replace league="Swiss Super League" if league=="Swiss Raiffeisen Super League"
replace league="Turkish Super Lig" if league=="Turkish Turkcell Super Lig"

encode league, gen(temp)
drop league
rename temp league

rename season temp
gen season=1 if temp==2017
replace season=2 if temp==2018
replace season=3 if temp==2019 & ghostgames==0
replace season=4 if temp==2019 & ghostgames==1
replace season=5 if temp==2020
label define season 1 "2017/18 " 2 "2018/19 " 3 "2019/20a" 4 "2019/20b" 5 "2020/21 ", modify
label values season season
tab season
drop temp

gen goals=score1+score2
mean goals, over(season)

gen xGs=xg1+xg2
mean xGs, over(season)

gen goaldiff=score1-score2




reg score1 i.season i.temp
reg score2 i.season i.temp

reg xg1 i.season i.temp
reg nsxg1 i.season i.temp

reg xg2 i.season i.temp
reg nsxg2 i.season i.temp

***
gen xGdiff=xg1-xg2
reg xGdiff i.season i.temp

mean xGdiff, over(season)

***
gen nsxGdiff=nsxg1-nsxg2
reg nsxGdiff i.season i.temp

***

gen shotperformance1=score1-xg1
sum shotperformance1, det
mean shotperformance1, over(season)

gen shotperformance2=score2-xg2
sum shotperformance2, det
mean shotperformance2, over(season)

***
gen homewin=0
replace homewin=1 if score1>score2
tab homewin

gen draw=0
replace draw=1 if score1==score2
tab draw

gen awaywin=0
replace awaywin=1 if score1<score2
tab awaywin

gen outcome=0
replace outcome=1 if score1>score2
replace outcome=-1 if score1<score2
tab outcome



