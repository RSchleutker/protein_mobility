template <- function (subset = TRUE, ...) {
  ps <- substitute(subset)
  xyplot(
    Normalized  ~ Time,
    data = summary,
    subset = eval(ps),
    groups = Condition,
    upper = summary$Upper,
    lower = summary$Lower,
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
