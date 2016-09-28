BAD_TABLES <- c('NULL', 'footerTextTbl')

extract.allCo <- function() {
  asx   <- read.csv('data/ASXListedCompanies.csv')
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
