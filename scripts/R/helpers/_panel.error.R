panel.error <- function(x, y, upper, lower, fill, col, subscripts, ...,
                        font, fontface) {

  ord <- order(x)

  x <- x[ord]
  lower <- lower[subscripts][ord]
  upper <- upper[subscripts][ord]

  panel.polygon(
    c(x, rev(x)),
    c(upper, rev(lower)),
    border = FALSE,
    col = paste0(fill, "40"),
    ...
  )
}