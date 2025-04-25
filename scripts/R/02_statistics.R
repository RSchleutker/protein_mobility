## Fit models and calculate statistics =========================================

# Since FORMULA is not linearizable, a non-linear approach was chosen to fit the
# function to the measured values. However, this does not guarantee to find a
# solution. Depending on the input values, `nls` might rise an error because it
# couldn't find a fit for whatever reason. Varying the starting parameters is
# crucial here.
formula <- Normalized ~ A * (1 - exp(-tau * Time))

models <- data_intensities %>%
  filter(Protein != "Gliotactin") %>%
  subset(Time >= 0) %>%
  split(~ Protein + Condition, drop = TRUE) %>%
  lapply(nls, formula = formula, start = c(A = 0.5, tau = 1))


# Following output is redirected to \output\statistics\models.txt.

# Model parameters.
models %>%
  sapply(coef) %>%
  round(3) %>%
  t()
#                          A   tau
# M6.Control           0.177 0.111
# Anakonda.Control     0.272 0.063
# M6.M6[3xCS]          0.194 0.229
# Anakonda.M6[3xCS]    0.280 0.073
# M6.Fas2[EB112]       0.823 0.822
# Anakonda.Fas2[EB112] 0.567 0.131
# M6.Gli[F156]         0.698 0.206
# Anakonda.Aka[PDZB]   0.304 0.067


# 95% confidence intervals for A.
models %>%
  sapply(confint, "A") %>%
  t() %>%
  round(3) %>%
  try() %>%
  print()
#                       2.5% 97.5%
# M6.Control           0.163 0.195
# Anakonda.Control     0.221 0.383
# M6.M6[3xCS]          0.185 0.206
# Anakonda.M6[3xCS]    0.234 0.367
# M6.Fas2[EB112]       0.800 0.846
# Anakonda.Fas2[EB112] 0.525 0.623
# M6.Gli[F156]         0.663 0.739
# Anakonda.Aka[PDZB]   0.229 0.560


# 95% confidence intervals for tau.
models %>%
  sapply(confint, "tau") %>%
  t() %>%
  round(3) %>%
  try() %>%
  print()
#                       2.5% 97.5%
# M6.Control           0.090 0.134
# Anakonda.Control     0.038 0.090
# M6.M6[3xCS]          0.189 0.279
# Anakonda.M6[3xCS]    0.048 0.102
# M6.Fas2[EB112]       0.665 1.047
# Anakonda.Fas2[EB112] 0.106 0.159
# M6.Gli[F156]         0.172 0.247
# Anakonda.Aka[PDZB]   0.028 0.112
