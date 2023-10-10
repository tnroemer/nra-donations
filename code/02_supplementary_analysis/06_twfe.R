#' ---
#' title: "Main analysis using TWFE"
#' ---
#'

pacman::p_load(
  tidyverse, fixest, broom
)

# load data
nra <- read_rds("data/nra_donations_donors.rds")

# prepare data
nra <- nra %>%
  group_by(id) %>%
  mutate(treat = ifelse(max(first_treatment) > 0, 1, 0)) %>%
  ungroup() %>%
  mutate(time_to_treat = ifelse(treat == 1, report_year - first_treatment, 0))

# run model
mod_twfe <- feols(donations ~ i(time_to_treat, treat, ref = -1) | id + report_year,
  data = nra,
  cluster = ~id
)

# plot
png("figures/SI.6/twfe.png", width = 24, height = 15, res = 300, units = "cm")
iplot(mod_twfe,
  ylim = c(-3500, 4000), xlab = "Years to Shooting",
  xlim = c(-4.3, 4.3),
  main = "",
  grid.par = list(vert = TRUE, horiz = TRUE)
)
dev.off()

# clean
pacman::p_unload("all")
rm(list = ls())
