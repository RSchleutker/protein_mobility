## Generate plots ==============================================================

trellis.par.set(theme = THEME)

plot_m6_glif156 <- xyplot_template(
  data = data_summary,
  subset = Protein == "M6" & Condition %in% c("Control", "Gli[F156]")
) |> print()

plot_m6_fas2eb112 <- xyplot_template(
  data = data_summary,
  subset = Protein == "M6" & Condition %in% c("Control", "Fas2[EB112]")
) |> print()

plot_aka_fas2eb112 <- xyplot_template(
  data = data_summary,
  subset = Protein == "Anakonda" & Condition %in% c("Control", "Fas2[EB112]")
) |> print()

plot_gli_fas2eb112 <- xyplot_template(
  data = data_summary,
  subset = Protein == "Gliotactin" & Condition %in% c("Control", "Fas2[EB112]")
) |> print()

plot_m6_m63xcs <- xyplot_template(
  data = data_summary,
  subset = Protein == "M6" & Condition %in% c("Control", "M6[3xCS]")
) |> print()

plot_aka_m63xcs <- xyplot_template(
  data = data_summary,
  subset = Protein == "Anakonda" & Condition %in% c("Control", "M6[3xCS]")
) |> print()

plot_aka_akapdzb <- xyplot_template(
  data = data_summary,
  subset = Protein == "Anakonda" & Condition %in% c("Control", "Aka[PDZB]")
) |> print()


## Export plots ================================================================

# Loop through all objects in the global environment and consider all those with
# names starting with 'plot_[...]'.
for (obj in ls(pattern = "plot_")) {
  current_plot <- get(obj)
  
  for (fmt in c("pdf", "png")) {
    device <- get(fmt)
    filename <- file.path(OUTPUT, "plots", paste0(obj, ".", fmt))
    
    if (fmt == "pdf")
      device(file = filename, WIDTH / 25, HEIGHT / 25)
    else
      device(file = filename, WIDTH, HEIGHT, units = "mm", res = DPI)
    
    trellis.par.set(theme)
    print(current_plot)
    
    dev.off()
    
  }
}
