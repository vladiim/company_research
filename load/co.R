load.allCo <- function() read.csv('data/all.csv')

load.allIndividualCo <- function() {
  d <- lapply(paste0('data/co/', dir('data/co', pattern='[.]csv$')), read.csv)
  Reduce(function(...) merge(..., all = TRUE), d)
}

load.allCoAndSave <- function() {
  write.csv(load.allIndividualCo(), 'data/all.csv')
}
