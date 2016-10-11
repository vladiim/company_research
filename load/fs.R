load.fs <- function() {
  read.csv('data/data.csv', stringsAsFactors = FALSE) %>%
    mutate(value = as.double(value)) %>%
    filter(!is.na(value)) %>%
    select(ticker, year, variable, value)
}
