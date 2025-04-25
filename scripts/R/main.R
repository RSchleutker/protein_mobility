library(dplyr)
library(openxlsx)
library(nlme)
library(lattice)


source_folder <- file.path("scripts", "R")


## Load helper functions =======================================================

source("./scripts/R/helpers/_theme.R")
source("./scripts/R/helpers/_plot_template.R")
source("./scripts/R/helpers/_panel.error.R")


## Define script-wide constants ================================================

WIDTH <- 80  # Standard width of plots in mm.
HEIGHT <- 50  # Standard height of plots in mm.
DPI <- 300  # Resolution of PNG plots.
THEME <- theme


# Read and process data --------------------------------------------------------
source(file.path(source_folder, "01_data_cleanup.R"))

# Run statistical analysis -----------------------------------------------------
source(file.path(source_folder, "02_statistics.R"))

# Create and export plots ------------------------------------------------------
source(file.path(source_folder, "03_visualization.R"))
