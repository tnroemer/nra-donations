#' ---
#' title: "Re-analysis of effect of school shootings on NRA donations using Pah et al. (2017) data"
#' ---

pacman::p_load(tidyverse, did, fixest)

# load data
nra <- read_rds('data/supplementary_analysis/nra_donations_donors_pah_et_al.rds')

source("code/03_functions/plot_functions_main.R")

# donations
m1 <- att_gt(
    data = nra,
    yname = "donations",
    gname = "first_treatment",
    tname = "report_year",
    idname = "id",
    base_period = "universal",
    panel = T
)

m1.es <- aggte(m1,
               type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
               clustervars = "id"
)

# donors
m2 <- att_gt(
    data = nra,
    yname = "n_donors",
    gname = "first_treatment",
    tname = "report_year",
    idname = "id",
    base_period = "universal",
    panel = T
)

m2.es <- aggte(m2,
               type = "dynamic", na.rm = T, balance_e = 4, min_e = -4,
               clustervars = "id"
)

m1_data <- m1.es %>%
    aggte_plot()
m2_data <- m2.es %>%
    aggte_plot()

dict <- c(
    c1 = "-4", c2 = "-3", c3 = "-2", c4 = "-1", c5 = "0", c6 = "1", c7 = "2",
    c8 = "3", c9 = "4"
)

# donors figures
png("figures/SI.2/nra_donations_pah_et_al.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m1_data),
         ylim = c(-1500, 3000), xlab = "Years to Shooting",
         title = NULL,
         sep = 0.25,
         style = "iplot",
         ref.line = 4,
         grid.par = list(vert = TRUE, horiz = TRUE),
         dict = dict
)
dev.off()

# donors figures
png("figures/SI.2/nra_donors_pah_et_al.png", width = 24, height = 15, res = 300, units = "cm", family = "Times New Roman")
coefplot(list(m2_data),
         ylim = c(-5, 10), xlab = "Years to Shooting",
         title = NULL,
         sep = 0.25,
         style = "iplot",
         ref.line = 4,
         grid.par = list(vert = TRUE, horiz = TRUE),
         dict = dict
)
dev.off()

pacman::p_unload("all")
rm(list = ls())