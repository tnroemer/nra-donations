#' ---
#' title: "Analysis of NRA ad spending"
#' ---

pacman::p_load(tidyverse, did, fixest)

# load data
ads <- read_rds("data/supplementary_analysis/nra_ad_spending.rds")

# estimate model
m1 <- att_gt(
  yname = "spending",
  tname = "t",
  idname = "id",
  gname = "first_treatment",
  panel = T,
  allow_unbalanced_panel = T,
  data = ads,
  base_period = "universal"
)

m1.es <- aggte(m1, min_e = -10, max_e = 5, type = "dynamic")

# prepare data for plotting
aggte_plot <- function(es) {
  m1_coefs <- es$att.egt
  m1_ses <- es$se.egt
  m1_ses[10] <- 0
  m1_period <- -10:5
  m1_data <- matrix(c(m1_coefs, m1_ses, rep(NA, 32)), ncol = 4)
  return(m1_data)
}

m1_data <- aggte_plot(m1.es)

# coefplot setup
dict <- c(
  c1 = "-10", c2 = "-9", c3 = "-8", c4 = "-7", c5 = "-6", c6 = "-5", c7 = "-4",
  c8 = "-3", c9 = "-2", c10 = "-1", c11 = "0", c12 = "1", c13 = "2", c14 = "3",
  c15 = "4", c16 = "5"
)

# plot
png("figures/SI.8/nra_ad_spending.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m1_data),
  ylim = c(-1000, 1500),
  xlab = "Weeks to Shooting",
  title = NULL,
  sep = 0.25,
  style = "iplot",
  ref.line = 10,
  grid.par = list(vert = TRUE, horiz = TRUE),
  dict = dict,
  ci.join = T,
  ci.width = 0,
  ci.lwd = 0,
  pt.join = T
)
dev.off()

pacman::p_unload("all")
rm(list = ls())
