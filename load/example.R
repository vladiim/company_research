load.example <- function() {
  d <- read.csv('./data/example.csv', head = TRUE, sep = ',' )
  d <- d[,2:11]
  transform.normVarNames(d)
}
