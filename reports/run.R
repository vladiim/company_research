runReport <- function() {
  input = './reports/templates/report.Rmd'
  output = paste0( './reports/output/report.md' )
  knit( input, output )
}