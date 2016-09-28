# extract text from annual report
# document analysis to compare similarities and differences in text

extract.annual <- function(file, pages) {
  d <- extract_tables(paste0('data/', file), pages = pages, method = 'data.frame')
}

extract.cleanData <- function(d, ticker) {
  d %>%
    mutate(year     = gsub('X', '', variable),
           value    = gsub(',', '', value),
           value    = gsub('-', '0', value),
           value    = gsub('\\(', '-', value),
           value    = gsub('\\)', '', value),
           value    = as.numeric(value),
           variable = X,
           ticker   = ticker) %>%
    filter(value != '') %>%
    select(ticker, year, variable, value)
}

extract.wpacKPI <- function(file = 'westpac_2015.pdf') {
  extract.cleanData(
    melt(extract.annual(file, 21)[[1]], id = 'X'),
    'WBC')
}

extract.wpacKPISave <- function() {
  write.csv(extract.wpacKPI(), 'data/westpac_kpis.csv')
}

extract.wpacFinancials <- function(file = 'westpac_2015.pdf') {
  d        <- extract.annual(file, 74)[[1]]
  names(d) <- c('X', '2015', '2014', '2013', '2012', '2011')
  extract.cleanData(melt(d, id = 'X'), 'WBC')
}

extract.wpacFinancialsSave <- function() {
  write.csv(extract.wpacFinancials(), 'data/westpac_financials.csv')
}
