xyplot_template <- function (data, subset = TRUE, ...) {
  ps <- substitute(subset)
  xyplot(
    Normalized  ~ Time,
    data = data,
    subset = eval(ps),
    groups = Condition,
    upper = data$Upper,
    lower = data$Lower,
    panel = \(x, y, ...) {
      panel.grid(-1, -1)
      panel.superpose(x, y, panel.groups = panel.error, ...)
      panel.superpose(x, y, panel.groups = panel.lines, ...)
    },
    type = "l",
    pch = 16,
    col = PALETTE,
    fill = PALETTE,
    xlab = "Time [min]",
    ylab = "Normalized\nintensity [a.u.]",
    ylim = c(-.12, 1.12),
    ...
  )
}
