extract.allCo <- function() {
  asx <- read.csv('data/ASXListedCompanies.csv')
  lapply(asx$ASX.code, extract.andSaveAusFund)
}

extract.fin <- function() {
  lapply(ASX_FIN_SERVICES$ticker, extract.andSaveAusFund)
}

extract.andSaveAusFund <- function(ticker) {
  url    <- paste0('http://uk.advfn.com/common/company/ASX/', ticker)
  tables <- readHTMLTable(url)
  if ('id_balanceSheet' %in% names(tables)) {
    print(paste0('Extracting data for: ', ticker))
    d <- extract.ausFund(ticker, tables)
    write.csv(d, paste0('data/co/', tolower(ticker), '-', d$date, '.csv'))
  } else {
    print(paste0('No balance sheet data for: ', ticker))
  }

}
extract.ausFund <- function(ticker, tables) {
  data.frame(
    ticker           = ticker,
    date             = as.Date(extract.fundamentalGeneralInfo(tables, 'End of fiscal year:'), format = '%d %B %Y'),
    name             = extract.fundamentalGeneralInfo(tables, 'Company name:'),
    est              = extract.fundamentalGeneralInfo(tables, 'Uear established:'),
    sector           = extract.fundamentalGeneralInfo(tables, 'Company sector name:'),
    industry         = extract.fundamentalGeneralInfo(tables, 'Industry name:'),
    industry_group   = extract.fundamentalGeneralInfo(tables, 'Industry group name:'),
    marcap           = extract.fundamental(tables, 'id_morningStarKeyRatios', 'Market Capitalisation', 1000),
    invested_capital = extract.fundamental(tables, 'id_balanceSheet', 'Invested Capital'),
    total_equity     = extract.fundamental(tables, 'id_balanceSheet', 'Total Equity'),
    total_debt       = extract.fundamental(tables, 'id_balanceSheet', 'Total Debt'),
    pretax_income    = extract.fundamental(tables, 'id_profitLoss',   'Net Income'),
    dividends        = extract.fundamental(tables, 'id_cashFlow', 'Cash Dividends Paid')
  ) %>%
  mutate(roic = (pretax_income + dividends) / invested_capital) %>%
  data.frame()
}
extract.fundamental <- function(tables, table, fundamental, times = 1) {
  val = tables[[table]]$V2[match(fundamental, tables[[table]]$V1)]
  as.numeric(gsub(',', '', val)) * times
}
extract.fundamentalGeneralInfo <- function(tables, fundamental) {
  tables[['id_generalCompanyInformation']][[2]][match(fundamental, tables[['id_generalCompanyInformation']][[1]])]
}
