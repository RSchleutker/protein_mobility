library(dplyr)
library(openxlsx)


## Define script-wide constants ================================================

INPUT <- "./data/processed/"
OUTPUT <-"./output/tables/"

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
intensities <- list.files(INPUT, "intensities", full = T, rec = T) %>%
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
summary <- intensities %>%
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

save(intensities, summary, file = paste0(OUTPUT, "intensities.RData"))

write.csv(intensities, paste0(OUTPUT, "intensities.csv"))
write.csv(summary, paste0(OUTPUT, "summary.csv"))

write.xlsx(
  list(
    Intensities = intensities,
    Summary = summary
  ),
  paste0(OUTPUT, "intensities.xlsx")
)
