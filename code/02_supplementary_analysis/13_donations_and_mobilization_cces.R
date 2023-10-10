#' ---
#' title: "Relationship between donations and other forms of political participation"
#' ---

pacman::p_load(tidyverse, fixest, modelsummary)

# load data
cces <- read_rds("data/supplementary_analysis/cces_mobilization.rds")

# estimate model
m1 <- feols(c(mobilize_meeting, mobilize_sign, mobilize_work, mobilize_protest, mobilize_contact) ~
                donate + age + female + factor(pid3) +
                full_time + part_time + unemployed + retired + student +
                black + white + asian + hispanic + 
                faminc |
                year, data = cces, cluster = ~zipcode
)

# display results
modelsummary(m1, stars = TRUE) 

pacman::p_unload("all")
rm(list = ls())
