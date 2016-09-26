plot.example <- function() {
  d <- transform.example()
  ggplot(d, aes(x = x, y = y)) +
    geom_point()
}
