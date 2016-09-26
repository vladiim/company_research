transform.normVarNames <- function(d) {
  names(d) <- tolower(names(d))
  names(d) <- gsub('\\.|\\s', '_', names(d))
  names(d) <- gsub('\\(|\\)', '', names(d))
  d
}
