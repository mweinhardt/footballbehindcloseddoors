

import delimited C:\Users\micha\Documents\Projekte\3_presentations\ESA2021\soccer-spi\soccer-spi\spi_matches.csv, clear

save "C:\Users\micha\Documents\Projekte\3_presentations\ESA2021\data\538_soccer_spi.dta", replace

***
use "C:\Users\micha\Documents\repos\closeddoors\data\538_soccer_spi.dta", clear

tab1 season league

drop if season==2021
drop if season==2016

bysort league: egen minseason=min(season)
tab minseason

drop if minseason>2017


drop if league=="UEFA Champions League"
drop if league=="UEFA Europa League"
drop if league=="Argentina Primera Division"
drop if league=="Brasileiro SÃ©rie A"
drop if league=="FA Women's Super League"
drop if league=="Major League Soccer"
drop if league=="Mexican Primera Division Torneo Apertura"
drop if league=="Mexican Primera Division Torneo Clausura"
drop if league=="National Women's Soccer League"

encode league, gen(temp)

tab temp

mean score1, over(season)

mean score1 if league=="German Bundesliga", over(season)
mean score1 if league=="German 2. Bundesliga", over(season)
mean score1 if league=="Barclays Premier League", over(season)
mean score1 if league=="English League Championship", over(season)
mean score1 if league=="English League One", over(season)
mean score1 if league=="English League Two", over(season)
mean score1 if league=="Spanish Primera Division", over(season)
mean score1 if league=="Spanish Segunda Division", over(season)	

mean score2, over(season)

mean score2 if league=="German Bundesliga", over(season)
mean score2 if league=="German 2. Bundesliga", over(season)
mean score2 if league=="Barclays Premier League", over(season)
mean score2 if league=="English League Championship", over(season)
mean score2 if league=="English League One", over(season)
mean score2 if league=="English League Two", over(season)
mean score2 if league=="Spanish Primera Division", over(season)
mean score2 if league=="Spanish Segunda Division", over(season)	

gen goals=score1+score2
mean goals, over(season)
mean goals if league=="German Bundesliga", over(season)
mean goals if league=="German 2. Bundesliga", over(season)
mean goals if league=="Barclays Premier League", over(season)
mean goals if league=="English League Championship", over(season)
mean goals if league=="English League One", over(season)
mean goals if league=="English League Two", over(season)
mean goals if league=="Spanish Primera Division", over(season)
mean goals if league=="Spanish Segunda Division", over(season)

gen xGs=xg1+xg2
mean xGs, over(season)
mean xGs if league=="German Bundesliga", over(season)
mean xGs if league=="German 2. Bundesliga", over(season)
mean xGs if league=="Barclays Premier League", over(season)
mean xGs if league=="English League Championship", over(season)
mean xGs if league=="English League One", over(season)
mean xGs if league=="English League Two", over(season)
mean xGs if league=="Spanish Primera Division", over(season)
mean xGs if league=="Spanish Segunda Division", over(season)

gen goaldiff=score1-score2
mean goaldiff, over(season)
mean score1, over(season)
mean score2, over(season)

mean goaldiff, over(temp)
reg goaldiff i.season i.temp 

forvalues n=1/20 {
reg goaldiff i.season i.temp if temp==`n'
}

reg score1 i.season i.temp
reg score2 i.season i.temp

reg xg1 i.season i.temp
reg nsxg1 i.season i.temp

reg xg2 i.season i.temp
reg nsxg2 i.season i.temp


mean goaldiff if league=="German Bundesliga", over(season)
mean goaldiff if league=="German 2. Bundesliga", over(season)
mean goaldiff if league=="Barclays Premier League", over(season)
mean goaldiff if league=="English League Championship", over(season)
mean goaldiff if league=="English League One", over(season)
mean goaldiff if league=="English League Two", over(season)
mean goaldiff if league=="Spanish Primera Division", over(season)
mean goaldiff if league=="Spanish Segunda Division", over(season)

***
gen xGdiff=xg1-xg2
reg xGdiff i.season i.temp

mean xGdiff, over(season)
mean xGdiff if league=="German Bundesliga", over(season)
mean xGdiff if league=="German 2. Bundesliga", over(season)
mean xGdiff if league=="Barclays Premier League", over(season)
mean xGdiff if league=="English League Championship", over(season)
mean xGdiff if league=="English League One", over(season)
mean xGdiff if league=="English League Two", over(season)
mean xGdiff if league=="Spanish Primera Division", over(season)
mean xGdiff if league=="Spanish Segunda Division", over(season)

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

reg homewin i.season i.temp
reg draw i.season i.temp
reg awaywin i.season i.temp

forvalues n=1/20 {
reg homewin i.season i.temp if temp==`n'
}

logit homewin i.season i.temp, or
logit draw i.season i.temp, or
logit awaywin i.season i.temp, or

mean homewin , over(season)
mean homewin if league=="German Bundesliga", over(season)
mean homewin if league=="German 2. Bundesliga", over(season)
mean homewin if league=="Barclays Premier League", over(season)
mean homewin if league=="English League Championship", over(season)
mean homewin if league=="English League One", over(season)
mean homewin if league=="English League Two", over(season)
mean homewin if league=="Spanish Primera Division", over(season)
mean homewin if league=="Spanish Segunda Division", over(season)

mean draw, over(season)
mean draw if league=="German Bundesliga", over(season)
mean draw if league=="German 2. Bundesliga", over(season)

mean awaywin, over(season)
mean awaywin if league=="German Bundesliga", over(season)
mean awaywin if league=="German 2. Bundesliga", over(season)
mean awaywin if league=="Barclays Premier League", over(season)
mean awaywin if league=="English League Championship", over(season)
mean awaywin if league=="English League One", over(season)
mean awaywin if league=="English League Two", over(season)
mean awaywin if league=="Spanish Primera Division", over(season)
mean awaywin if league=="Spanish Segunda Division", over(season)
