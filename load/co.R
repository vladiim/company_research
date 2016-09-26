load.allCo <- function() {
  d <- lapply(paste0('data/co/', dir('data/co', pattern='[.]csv$')), read.csv)
  Reduce(function(...) merge(..., all = TRUE), d)
}
