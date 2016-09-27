BAD_TABLES <- c('NULL', 'footerTextTbl')

extract.allCo <- function() {
  asx   <- read.csv('data/ASXListedCompanies.csv') # %>%
    # filter(as.character(ASX.code) > 'HIL')
  # NOTE: above to deal with error mid scrape
  cores <- detectCores() - 1
  cl    <- makeForkCluster(cores)
  parLapply(cl, asx$ASX.code, extract.andSaveAusFund)
  stopCluster(cl)
}

extract.andSaveAusFund <- function(ticker) {
  url         <- paste0('http://uk.advfn.com/common/company/ASX/', ticker)
  tables      <- readHTMLTable(url)
  table_names <- setdiff(names(tables), BAD_TABLES)
  tryCatch({
    date        <- extract.fundamentalGeneralInfo(tables, 'End of fiscal year:')
    dlist       <- lapply(table_names, function(table_name) {
      extract.fund(table_name, tables, ticker, date)
    })
    d <- Reduce(function(...) merge(..., all = TRUE), dlist)
    write.csv(d, paste0('data/co/', tolower(ticker), '-', gsub('\\s', '-', tolower(date)), '.csv'))
  }, error = function(e) {
    print(paste0('Error: ', e))
  })
}

extract.fund <- function(table_name, tables, ticker, date) {
  times <- nrow(tables[[table_name]])
  data.frame(
    ticker   = rep(ticker, times),
    date     = rep(date, times),
    variable = tables[[table_name]][[1]],
    value    = tables[[table_name]][[2]]
  )
}
extract.fundamentalGeneralInfo <- function(tables, fundamental) {
  tables[['id_generalCompanyInformation']][[2]][match(fundamental, tables[['id_generalCompanyInformation']][[1]])]
}

# extract.fin <- function() {
#   lapply(ASX_FIN_SERVICES$ticker, extract.andSaveAusFund)
# }
#
# extract.andSaveAusFund <- function(ticker) {
#   url    <- paste0('http://uk.advfn.com/common/company/ASX/', ticker)
#   tables <- readHTMLTable(url)
#   if ('id_balanceSheet' %in% names(tables)) {
#     print(paste0('Extracting data for: ', ticker))
#     d <- extract.ausFund(ticker, tables)
#     write.csv(d, paste0('data/co/', tolower(ticker), '-', d$date, '.csv'))
#   } else {
#     print(paste0('No balance sheet data for: ', ticker))
#   }
#
# }
# extract.ausFund <- function(ticker, tables) {
#   data.frame(
#     ticker           = ticker,
#     date             = as.Date(extract.fundamentalGeneralInfo(tables, 'End of fiscal year:'), format = '%d %B %Y'),
#     name             = extract.fundamentalGeneralInfo(tables, 'Company name:'),
#     est              = extract.fundamentalGeneralInfo(tables, 'Uear established:'),
#     sector           = extract.fundamentalGeneralInfo(tables, 'Company sector name:'),
#     industry         = extract.fundamentalGeneralInfo(tables, 'Industry name:'),
#     industry_group   = extract.fundamentalGeneralInfo(tables, 'Industry group name:'),
#     marcap           = extract.fundamental(tables, 'id_morningStarKeyRatios', 'Market Capitalisation', 1000),
#     invested_capital = extract.fundamental(tables, 'id_balanceSheet', 'Invested Capital'),
#     total_equity     = extract.fundamental(tables, 'id_balanceSheet', 'Total Equity'),
#     total_debt       = extract.fundamental(tables, 'id_balanceSheet', 'Total Debt'),
#     pretax_income    = extract.fundamental(tables, 'id_profitLoss',   'Net Income'),
#     dividends        = extract.fundamental(tables, 'id_cashFlow', 'Cash Dividends Paid')
#   ) %>%
#   mutate(roic = (pretax_income + dividends) / invested_capital) %>%
#   data.frame()
# }
# extract.fundamental <- function(tables, table, fundamental, times = 1) {
#   val = tables[[table]]$V2[match(fundamental, tables[[table]]$V1)]
#   as.numeric(gsub(',', '', val)) * times
# }
# extract.fundamentalGeneralInfo <- function(tables, fundamental) {
#   tables[['id_generalCompanyInformation']][[2]][match(fundamental, tables[['id_generalCompanyInformation']][[1]])]
# }
