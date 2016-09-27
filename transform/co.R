transform.co <- function() {
  load.allCo() %>%
    filter(!is.na(ticker), !is.na(marcap), !is.na(roic))
}
