plot.fsRoicShare <- function() {
  plot <- ggplot(transform.fsRoicShare(),
    aes(x = market_share, y = roic, color = ticker)) +
    geom_point()
  plot.simpleTheme(plot) +
    scale_y_continuous(labels = percent) +
    scale_x_continuous(labels = percent)
}
