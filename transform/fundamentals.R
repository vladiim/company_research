###############################################################################
# Load Systematic Investor Toolbox (SIT)
# http://systematicinvestor.wordpress.com/systematic-investor-toolbox/
###############################################################################
# con = gzcon(url('http://www.systematicportfolio.com/sit.gz', 'rb'))
#     source(con)
# close(con)

roic <- function(d) {
  d['Return on Capital Invested (ROCI)',]
}


###############################################################################
# determine date when fundamental data is available
# use 'date preliminary data loaded' when available
# otherwise lag 'quarter end date' 2 months for Q1/2/3 and 3 months for Q4
###############################################################################
date.fund.data <- function(data)
{
    # construct date
    quarter.end.date = as.Date(paste(data['quarter end date',], '/1', sep=''), '%Y/%m/%d')
    quarterly.indicator = data['quarterly indicator',]
    date.preliminary.data.loaded = as.Date(data['date preliminary data loaded',], '%Y-%m-%d') + 1

    months = seq(quarter.end.date[1], tail(quarter.end.date,1)+365, by='1 month')
    index = match(quarter.end.date, months)
    quarter.end.date = months[ iif(quarterly.indicator == '4', index+3, index+2) + 1 ] - 1

    fund.date = date.preliminary.data.loaded
        fund.date[is.na(fund.date)] = quarter.end.date[is.na(fund.date)]

    return(fund.date)
}

#*****************************************************************
# Load historical fundamental data
# http://advfn.com/p.php?pid=financials&symbol=NYSE:WMT&mode=quarterly_reports
#******************************************************************
# Symbol = 'NYSE:WMT'
# sym = 'ASX:WBC'
# fund = fund.data(Symbol, 80)
#
# # construct date
# fund.date = date.fund.data(fund)
#
# #*****************************************************************
# # Create and Plot Earnings per share
# #******************************************************************
# EPS.Q = as.double(fund['Diluted EPS from Total Operations',])
#     EPS.Q = as.xts(EPS.Q, fund.date)
# EPS = runSum(EPS.Q, 4)
#
# # Plot
# layout(1:2)
# par(mar=c(2,2,2,1))
# x = barplot(EPS.Q, main='Wal-Mart Quarterly Earnings per share', border=NA)
# text(x, EPS.Q, fund['quarterly indicator',], adj=c(0.5,-0.3), cex=0.8, xpd = TRUE)
#
# barplot(EPS, main='Wal-Mart Rolling Annual Earnings per share', border=NA)
