transform.co <- function() {
  load.allCo() # %>%
    # filter(!is.na(ticker), !is.na(marcap), !is.na(roic))
}

transform.coROIC <- function() {
  d <- transform.co() # %>%
  d$roic <- lapply(d, transform.individualROIC)
}

transform.individualROIC <- function(d) {

}
