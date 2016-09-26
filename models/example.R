models.example <- function() {
  d <- transform.example()
  lm(price ~ ., data = d)
}
