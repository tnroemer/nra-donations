#' ---
#' title: "Analysis of donations to Giffords PAC"
#' ---

pacman::p_load(tidyverse, did, fixest)

giffords <- read_rds("data/supplementary_analysis/giffords_donations_donors.rds")

source("code/03_functions/plot_functions_main.R")

m1 <- att_gt(
    data = giffords,
    yname = "donations",
    gname = "first_treatment",
    tname = "report_year",
    idname = "id",
    base_period = "universal"
)

# Prepare Event Study
m1.es <- aggte(m1,
               type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
               clustervars = "id"
)

m2 <- att_gt(
    data = giffords,
    yname = "n_donors",
    gname = "first_treatment",
    tname = "report_year",
    idname = "id",
    base_period = "universal"
)

# Prepare Event Study
m2.es <- aggte(m2,
               type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
               clustervars = "id"
)

# coefplot setup
dict <- c(
    c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
    c8 = "3", c9 = "4"
)

m1_data <- m1.es %>%
    aggte_plot()
m2_data <- m2.es %>%
    aggte_plot()

# donations figure
png("figures/SI.9/giffords_donations.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m1_data),
         ylim = c(-6000, 10000), xlab = "Years to Shooting",
         title = NULL,
         sep = 0.25,
         style = "iplot",
         ref.line = 4,
         grid.par = list(vert = TRUE, horiz = TRUE),
         dict = dict,
         ci.join = T,
         ci.width = 0,
         ci.lwd = 0,
         pt.join = T
)
dev.off()

# donors figure
png("figures/SI.9/giffords_donors.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m2_data),
         ylim = c(-12, 20), xlab = "Years to Shooting",
         title = NULL,
         sep = 0.25,
         style = "iplot",
         ref.line = 4,
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
