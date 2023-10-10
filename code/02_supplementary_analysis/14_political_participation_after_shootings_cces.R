#' ---
#' title: "Political participation after school shootings"
#' ---

pacman::p_load(tidyverse, fixest, modelsummary)

# load data
cces <- read_rds("data/supplementary_analysis/cces_political_participation.rds")

# estimate model
m1 <- feols(c(mobilize_meeting, mobilize_sign, mobilize_work, mobilize_protest, mobilize_contact, donate) ~ post*gunown + female + age + faminc + educ + black +
                white + asian + hispanic + full_time + part_time + unemployed + retired + student,
            data = cces, cluster = ~zipcode)

# display results
modelsummary(m1, stars = TRUE)

pacman::p_unload("all")
rm(list = ls())
