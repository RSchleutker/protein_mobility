library(lattice)

source("./scripts/R/helpers/_theme.R")
source("./scripts/R/helpers/_plot_template.R")
source("./scripts/R/helpers/_panel.error.R")


## Define script-wide constants ================================================

INPUT <- "./output/tables/intensities.RData"
OUTPUT <- "./output/plots/"
WIDTH <- 80  # Standard width of plots in mm.
HEIGHT <- 50  # Standard height of plots in mm.
DPI <- 300  # Resolution of PNG plots.
MODE <- "export"  # Either 'export' or 'show'.
THEME <- theme


## Load data from .RData file ==================================================

load(INPUT)


## Generate plots ==============================================================

trellis.par.set(theme = THEME)

plot_m6_glif156 <- template(
  Protein == "M6" & Condition %in% c("Control", "Gli[F156]")
) |> print()

plot_m6_fas2eb112 <- template(
  Protein == "M6" & Condition %in% c("Control", "Fas2[EB112]")
) |> print()

plot_aka_fas2eb112 <- template(
  Protein == "Anakonda" & Condition %in% c("Control", "Fas2[EB112]")
) |> print()

plot_gli_fas2eb112 <- template(
  Protein == "Gliotactin" & Condition %in% c("Control", "Fas2[EB112]")
) |> print()

plot_m6_m63xcs <- template(
  Protein == "M6" & Condition %in% c("Control", "M6[3xCS]")
) |> print()

plot_aka_m63xcs <- template(
  Protein == "Anakonda" & Condition %in% c("Control", "M6[3xCS]")
) |> print()

plot_aka_akapdzb <- template(
  Protein == "Anakonda" & Condition %in% c("Control", "Aka[PDZB]")
) |> print()


## Export plots ================================================================

# Loop through all objects in the global environment and consider all those with
# names starting with 'plot_[...]'.
for(obj in ls(pattern = "plot_")) print(obj) {

  current_plot <- get(obj)

  # Export as PDF.
  pdf(
    file = paste0(OUTPUT, "pdf/", obj, ".pdf"),
    width = WIDTH/25, height = HEIGHT/25
  )

  trellis.par.set(theme = THEME)
  print(current_plot)

  dev.off()

  # Export as PNG.
  png(
    file = paste0(OUTPUT, "png/", obj, ".png"),
    width = WIDTH, height = HEIGHT,
    units = "mm", res = DPI
  )

  trellis.par.set(theme = THEME)
  plot_m6_glif156 |> print()

  dev.off()

}
