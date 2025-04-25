library(dplyr)
library(openxlsx)


## Define script-wide constants ================================================

INPUT <- file.path("data", "processed")
OUTPUT <- file.path("output")

PROTEINS <- c(
  "M6" = "M6",
  "Aka" = "Anakonda",
  "Gli" = "Gliotactin"
)
CONDITIONS <- c(
  "Wt" = "Control",
  "Palm" = "M6[3xCS]",
  "Eb112" = "Fas2[EB112]",
  "F156" = "Gli[F156]",
  "Pdzb" = "Aka[PDZB]"
)


## Read and process measured intensities =======================================

# Main dataframe.
data_intensities <- list.files(INPUT, "intensities", full = T, rec = T) %>%
  lapply(read.csv) %>%
  Reduce(f = rbind) %>%
  rename(
    Protein = "Prot",
    Condition = "Allele",
    Expression = "Expr",
    Embryo = "Emb"
  ) %>%
  mutate(
    Date = as.Date(as.character(Date), format = "%Y%m%d"),
    Protein = factor(Protein, names(PROTEINS), PROTEINS),
    Condition = factor(Condition, names(CONDITIONS), CONDITIONS)
  ) %>%
  ungroup() %>%
  mutate(
    Group = interaction(Protein, Condition, drop = TRUE)
  )

# Summarised data containing mean values and standard deviations.
data_summary <- data_intensities %>%
  group_by(Protein, Expression, Condition, Time) %>%
  summarise(
    Deviation = sd(Normalized),
    Normalized = mean(Normalized),
    Lower = Normalized - Deviation,
    Upper = Normalized + Deviation,
    Samples = n()
  ) %>%
  arrange(Time) %>%
  ungroup()


## Export cleaned data to CSV and EXCEL ========================================

write.csv(data_intensities, file.path(OUTPUT, "tables", "intensities.csv"))
write.csv(data_summary, file.path(OUTPUT, "tables", "summary.csv"))

write.xlsx(
  list(
    Intensities = data_intensities,
    Summary = data_summary
  ),
  file.path(OUTPUT, "tables", "intensities.xlsx")
)
