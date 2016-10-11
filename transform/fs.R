transform.fs <- function() {
  load.fs() %>%
    group_by(variable, year) %>%
      mutate(market_share = value / sum(value)) %>%
    ungroup()
}

transform.fsRoicShare <- function() {
  transform.fs() %>%
    filter(variable == 'Revenue',
           # only have data for CBA
           year     != 2016) %>%
    select(ticker, year, market_share) %>%
    left_join(transform.fsRoic(), by = c('ticker', 'year'))
}

transform.fsRoic <- function() {
  transform.fs() %>%
    filter(variable == 'ROIC') %>%
    mutate(roic = value) %>%
    select(ticker, year, roic)
}

# transform.fsShare <- function() {
#   transform.fs() %>%
#     filter(variable == 'Revenue',
#            ticker != 'ANZ') %>%
#     group_by(year) %>%
#       mutate(market_share = value / sum(value))
# }
