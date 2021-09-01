

global path "C:\Users\mweinhardt\repos\closeddoors\"

*______________________________________________________________________________________________________
*______________________________________________________________________________________________________
*______________________________________________________________________________________________________

***538

cd c:\temp\

clear
import delimited $path\data\spi_matches.csv, delimiter(",") encoding(utf8) 
save c:\temp\538xG.dta, replace

split date, parse("-")
destring date3 date2 date1 , replace
sort date1 date2 date3

encode league, gen(leagues)

keep if league=="German Bundesliga" | /// 
				league=="German 2. Bundesliga" | /// 
				league=="Austrian T-Mobile Bundesliga" | ///
				league=="Barclays Premier League" | ///
				league=="Belgian Jupiler League" | ///
				league=="Danish SAS-Ligaen" | ///
				league=="English League Championship" | ///
				league=="English League One" | ///
				league=="English League Two" | ///
				league=="Italy Serie A" | ///
				league=="Italy Serie B" | ///
				league=="Greek Super League" | ///
				league=="Portuguese Liga" | ///
				league=="Scottish Premiership" | ///
				league=="Spanish Primera Division" | ///
				league=="Spanish Segunda Division" | ///
				league=="Swedish Allsvenskan" | ///
				league=="Swiss Raiffeisen Super League" | ///
				league=="Turkish Turkcell Super Lig"		
 /*	            Argentina Primera Division |        979        2.32        2.32
                    Australian A-League |        288        0.68        3.00
           Austrian T-Mobile Bundesliga |        702        1.66        4.67
                Barclays Premier League |      1,900        4.51        9.17
                 Belgian Jupiler League |        816        1.93       11.11
                     Brasileiro Série A |      1,520        3.60       14.71
                   Chinese Super League |        369        0.87       15.59
                      Danish SAS-Ligaen |        618        1.47       17.05
                       Dutch Eredivisie |      1,224        2.90       19.96
            English League Championship |      2,223        5.27       25.23
                     English League One |      1,514        3.59       28.82
                     English League Two |      1,554        3.68       32.50
                FA Women's Super League |        469        1.11       33.61
                         French Ligue 1 |      1,900        4.51       38.12
                         French Ligue 2 |      1,520        3.60       41.72
                   German 2. Bundesliga |      1,224        2.90       44.63
                      German Bundesliga |      1,530        3.63       48.25
                     Greek Super League |        480        1.14       49.39
                          Italy Serie A |      1,900        4.51       53.90
                          Italy Serie B |      1,594        3.78       57.68
                      Japanese J League |        759        1.80       59.48
                    Major League Soccer |      1,534        3.64       63.11
Mexican Primera Division Torneo Apert.. |        672        1.59       64.71
Mexican Primera Division Torneo Claus.. |        654        1.55       66.26
                     NWSL Challenge Cup |         23        0.05       66.31
         National Women's Soccer League |        450        1.07       67.38
                  Norwegian Tippeligaen |        960        2.28       69.66
                        Portuguese Liga |      1,224        2.90       72.56
                   Russian Premier Liga |        960        2.28       74.83
                   Scottish Premiership |        852        2.02       76.85
      South African ABSA Premier League |        480        1.14       77.99
               Spanish Primera Division |      1,900        4.51       82.50
               Spanish Segunda Division |      1,865        4.42       86.92
                    Swedish Allsvenskan |        960        2.28       89.20
          Swiss Raiffeisen Super League |        630        1.49       90.69
             Turkish Turkcell Super Lig |      1,338        3.17       93.86
                  UEFA Champions League |        494        1.17       95.03
                     UEFA Europa League |        607        1.44       96.47
                   United Soccer League |      1,487        3.53      100.00
*/
				   
rename score1 homegoals
rename score2 awaygoals

gen outcome=0
replace outcome=1 if homegoals>awaygoals
replace outcome=2 if homegoals==awaygoals
replace outcome=3 if homegoals<awaygoals
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

gen sample=0
replace sample=1 if date1==2020 & date2>3 & season==2019
tab sample

tab outcome season if sample==0, col

tab outcome sample if season==2019, col

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

*keep if season==2019 | season==2018				   

tab outcome if season==2018
tab outcome sample  if season==2019, col

keep if season<2020
keep if season>2016
mlogit outcome sample i.season i.leagues 

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=xxx; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

*graph export $path\graphs\Outcome.png, replace

***

gen xghome=round(xg1)
gen xgaway=round(xg2)

gen outcomexg=0
replace outcomexg=1 if xghome>xgaway
replace outcomexg=2 if xghome==xgaway
replace outcomexg=3 if xghome<xgaway
label define outcomexg 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcomexg outcomexg
tab outcomexg

tab outcomexg sample, col

hist outcomexg, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\graphs\outcomexg.png, replace


***

gen netgoals=homegoals-awaygoals

mean netgoals if season==2018
mean netgoals if season==2019, over(sample)
reg netgoals sample spi1 spi2 importance1 importance2 i.season i.leagues 

gen netxg=xg1-xg2
mean netxg if season==2018
mean netxg if season==2019, over(sample)
reg netxg i.sample i.season
reg netgoals i.sample i.season

reg netxg sample i.season i.leagues 
reg netxg sample spi1 spi2 importance1 importance2 i.season i.leagues 

***
gen netxg2=nsxg1-nsxg2
mean netxg2 if season==2018
mean netxg2 if season==2019, over(sample)
reg netxg2 i.sample i.season
reg netxg2 i.sample i.season

reg netxg2 sample i.season i.leagues 
reg netxg2 sample spi1 spi2 importance1 importance2 i.season i.leagues 

hist netxg, by(sample)

***
gen shotprecision1=homegoals-xg1
sum shotprecision1, det
mean shotprecision1  if season==2019, over(sample)
hist shotprecision1
reg shotprecision1 sample spi1 spi2 importance1 importance2 i.season i.leagues 

gen shotprecision2=awaygoals-xg2
sum shotprecision2, det
mean shotprecision2  if season==2019, over(sample)
hist shotprecision2
reg shotprecision2 sample spi1 spi2 importance1 importance2 i.season i.leagues 

gen shot_precision_diff=shotprecision1-shotprecision2
sum shot_precision_diff, det
hist shot_precision_diff
reg shot_precision_diff sample spi1 spi2 importance1 importance2 i.season i.leagues 

order  shotprecision1 homegoals xg1 shotprecision2 awaygoals xg2


***

rename league leaguestr
encode leaguestr, gen(league)
tab league

reg netxg sample i.league

***
destring homegoals awaygoals, replace
gen goaldiff=homegoals-awaygoals

hist goaldiff

reg goaldiff sample i.league


***FOOTBALLxG

cd c:\temp\

clear
import delimited $path\data\FootballxG_League_Tables_Full_Data_data.csv, delimiter(";") encoding(utf8) 
save c:\temp\FootballxG.dta, replace

split date, parse(".")
destring date3 date2 date1 , replace
sort date3 date2 date1

split score, parse("-")
rename score1 homegoals
rename score2 awaygoals

gen outcome=0
replace outcome=1 if homegoals>awaygoals
replace outcome=2 if homegoals==awaygoals
replace outcome=3 if homegoals<awaygoals
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

gen sample=0
replace sample=1 if date3==2020 & date2>3
tab sample

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\graphs\Outcome.png, replace

***
gen outcomexg=0
replace outcomexg=1 if xgpts==3
replace outcomexg=2 if xgpts==1
replace outcomexg=3 if xgpts==0
label define outcomexg 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcomexg outcomexg
tab outcomexg

tab outcomexg sample, col

hist outcomexg, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\graphs\outcomexg.png, replace

***
tab league if league==4
hist outcomexg if league==4, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 
graph export $path\graphs\Germany1xg.png, replace

tab league if league==3
hist outcomexg if league==3, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 
graph export $path\graphs\Germany2xg.png, replace

***

hist netxg
mean netxg, over(sample)

***

rename league leaguestr
encode leaguestr, gen(league)
tab league

reg netxg sample i.league

***
destring homegoals awaygoals, replace
gen goaldiff=homegoals-awaygoals

hist goaldiff

reg goaldiff sample i.league

*______________________________________________________________________________________________________
*______________________________________________________________________________________________________
*______________________________________________________________________________________________________


***FOOTBALLxG

cd c:\temp\

clear
import delimited $path\data\FootballxG_League_Tables_Full_Data_data.csv, delimiter(";") encoding(utf8) 
save c:\temp\FootballxG.dta, replace

split date, parse(".")
destring date3 date2 date1 , replace
sort date3 date2 date1

split score, parse("-")
rename score1 homegoals
rename score2 awaygoals

gen outcome=0
replace outcome=1 if homegoals>awaygoals
replace outcome=2 if homegoals==awaygoals
replace outcome=3 if homegoals<awaygoals
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

gen sample=0
replace sample=1 if date3==2020 & date2>3
tab sample

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\graphs\Outcome.png, replace

***
gen outcomexg=0
replace outcomexg=1 if xgpts==3
replace outcomexg=2 if xgpts==1
replace outcomexg=3 if xgpts==0
label define outcomexg 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcomexg outcomexg
tab outcomexg

tab outcomexg sample, col

hist outcomexg, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\graphs\outcomexg.png, replace

***
tab league if league==4
hist outcomexg if league==4, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 
graph export $path\graphs\Germany1xg.png, replace

tab league if league==3
hist outcomexg if league==3, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 
graph export $path\graphs\Germany2xg.png, replace

***

hist netxg
mean netxg, over(sample)

***

rename league leaguestr
encode leaguestr, gen(league)
tab league

reg netxg sample i.league

***
destring homegoals awaygoals, replace
gen goaldiff=homegoals-awaygoals

hist goaldiff

reg goaldiff sample i.league




***FOOTBALLxG

cd c:\temp\

clear
import delimited $path\data\FootballxG_League_Tables_Full_Data_data.csv, delimiter(";") encoding(utf8) 
save c:\temp\FootballxG.dta, replace

split date, parse(".")
destring date3 date2 date1 , replace
sort date3 date2 date1

split score, parse("-")
rename score1 homegoals
rename score2 awaygoals

gen outcome=0
replace outcome=1 if homegoals>awaygoals
replace outcome=2 if homegoals==awaygoals
replace outcome=3 if homegoals<awaygoals
label define outcome 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcome outcome
tab outcome

gen sample=0
replace sample=1 if date3==2020 & date2>3
tab sample

label define sample 0 "With supporters" 1 "Without supporters"
label values sample sample
tab sample

tab outcome sample, col

hist outcome, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\graphs\Outcome.png, replace

***
gen outcomexg=0
replace outcomexg=1 if xgpts==3
replace outcomexg=2 if xgpts==1
replace outcomexg=3 if xgpts==0
label define outcomexg 1 "Home win" 2 "Draw" 3 "Away win", modify
label values outcomexg outcomexg
tab outcomexg

tab outcomexg sample, col

hist outcomexg, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 

graph export $path\graphs\outcomexg.png, replace

***
tab league if league==4
hist outcomexg if league==4, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 
graph export $path\graphs\Germany1xg.png, replace

tab league if league==3
hist outcomexg if league==3, discrete percent by(sample, legend(off) note(Games with supporters: N=2202; Games without supporters: N=778)) xlabel(3 "Away win" 2 "Draw" 1 "Home win") ylabel(0 10 20 30 40 50 60) addlabels scheme(sj) 
graph export $path\graphs\Germany2xg.png, replace

***

hist netxg
mean netxg, over(sample)

***

rename league leaguestr
encode leaguestr, gen(league)
tab league

reg netxg sample i.league

***
destring homegoals awaygoals, replace
gen goaldiff=homegoals-awaygoals

hist goaldiff

reg goaldiff sample i.league

