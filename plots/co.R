plot.co <- function() {
  plot <- ggplot(transform.co(), aes(x = marcap, y = roic, label = ticker, color = ticker)) +
    geom_text(check_overlap = TRUE)
  plot.simpleTheme(plot) +
    scale_y_continuous(labels = percent) +
    scale_x_continuous(labels = plot.millions) +
    xlab('Market Capitalisation') + ylab('ROIC')
}
