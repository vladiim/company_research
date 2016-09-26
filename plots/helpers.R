plot.millions <- function(d) paste0('$', round(d / 1000000, 1), 'm')

# ---------- HELPERS

plot.simpleTheme <- function(plot) {
  plot.simpleThemeMoreColors(plot) +
    scale_colour_brewer(palette = 'Set2' ) +
    scale_fill_brewer(palette   = 'Set2' )
}

plot.simpleThemeMoreColors <- function(plot) {
  plot +
    scale_y_continuous(labels = comma) +
    theme_bw() + xlab('') + ylab('') +
    theme(axis.text.x           = element_text(angle = 45, hjust = 1)) +
    theme(panel.grid.major.x    = element_blank(),
          panel.grid.major.y    = element_blank(),
          panel.grid.minor.y    = element_blank())
}

# ---------- GRAPH TYPES

plot.dateLine <- function(plot) {
  plot <- plot +
    geom_line() +
    scale_x_date(labels = date_format('%b-%y'), breaks = date_breaks('months'), minor_breaks = date_breaks('1 week'))
  plot.simpleTheme(plot)
}

plot.dateBar <- function(plot) {
  plot <- plot +
    geom_bar(stat = 'identity', position = 'dodge') +
    scale_x_date(labels = date_format('%b-%y'), breaks = date_breaks('months'), minor_breaks = date_breaks('1 week'))
  plot.simpleTheme(plot)
}

plot.flippedBar <- function(plot) {
  plot <- plot +
    geom_bar(stat = 'identity', position = 'dodge') +
    coord_flip()
  plot.simpleTheme(plot)
}
