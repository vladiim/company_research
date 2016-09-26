vars.currentTime <- function() {
  datetime = gsub( ' ', '_', Sys.time() )
  datetime = gsub( '/', '-', datetime)
  datetime = gsub( ':', '-', datetime)
}