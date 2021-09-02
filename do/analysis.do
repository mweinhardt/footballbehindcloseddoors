
mean score1, over(season)
mean score1, over(ghostgames)

mean score2, over(season)
mean score2, over(ghostgames)

mean goaldiff, over(season)
reg goaldiff i.season i.league 
monthcount

mean goaldiff, over(season)
mean score1, over(season)
mean score2, over(season)

mean goaldiff, over(temp)
mean goaldiff, over(ghostgames)

reg goaldiff i.season i.league 

mean homewin, over(season)
mean draw, over(season)
mean awaywin, over(season)
mean goaldiff, over(season)
mean score1, over(season)
mean score2, over(season)

mean goaldiff, over(monthcount)

reg goaldiff i.season i.league ghostgames
reg score1 i.season i.league ghostgames
reg score2 i.season i.league ghostgames

reg goaldiff monthcount i.league ghostgames

mean homewin, over(ghostgames)

reg homewin  i.season i.league
reg homewin monthcount i.league i.season, vce(robust)
reg homewin i.season monthcount i.league ghostgames, vce(robust)
reg draw monthcount i.league ghostgames, vce(robust)
reg awaywin monthcount i.league ghostgames, vce(robust)

forvalues n=1/20 {
reg goaldiff i.season i.temp if temp==`n'
}


logit homewin i.league i.season, or
logit draw monthcount i.league ghostgames, or
logit awaywin monthcount i.league ghostgames, or

mlogit outcome monthcount i.league ghostgames

forvalues n=1/20 {
reg homewin i.season i.temp if temp==`n'
}


mean homewin , over(season)

mean draw, over(season)
mean draw if league=="German Bundesliga", over(season)
mean draw if league=="German 2. Bundesliga", over(season)

mean awaywin, over(season)



reg xGdiff monthcount i.league ghostgames

reg shotperformance1 monthcount i.league ghostgames



reg shotperformance2 monthcount i.league ghostgames
