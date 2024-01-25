#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Muhammad Aaraiz
# Date: 24 Janaury 2024
# Contact: muhammad.aaraiz@mail.utoronto.ca
# License: MIT

lm_model <- lm(arrest_count ~ age_cohort + sex, data = cleaned_full_data)

# Summary of the linear regression model
summary(lm_model)