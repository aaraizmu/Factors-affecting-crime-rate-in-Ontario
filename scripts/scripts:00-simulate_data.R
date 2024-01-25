#### Preamble ####
# Purpose: Simulates Data [Arrested and Charged Person]
# Author: Muuhammad Aaraiz
# Date: 24th January 2024
# Contact: muhammad.aaraiz@mail.utoronto.ca
# License: MIT
# Pre-requisites: Library tibble

# Load necessary libraries
library(tibble)

# Function to simulate data
simulate_data <- function(n_obs = 1000) {
  set.seed(123)  # Set seed for reproducibility
  
  # Simulate data
  data <- tibble(
    `_id` = 1:n_obs,
    ARREST_YEAR = sample(2014:2022, n_obs, replace = TRUE),
    DIVISION = sample(c("D14", "D12", "D22", "D52", "D43", "D31", "D55", "D32"), n_obs, replace = TRUE),
    HOOD_158 = sample(1:200, n_obs, replace = TRUE),
    NEIGHBOURHOOD_158 = paste("Neighbourhood", HOOD_158),
    SEX = sample(c("Male", "Female"), n_obs, replace = TRUE),
    AGE_COHORT = sample(c("<18", "18 to 24", "25 to 34", "35 to 44"), n_obs, replace = TRUE),
    AGE_GROUP = sample(c("Youth", "Adult"), n_obs, replace = TRUE),
    CATEGORY = sample(c("Other Criminal Code Violations", "Crimes Against the Person", "Controlled Drugs and Substances Act"), n_obs, replace = TRUE),
    SUBTYPE = sample(c("Other", "Assaults", "Theft Under $5000", "Break and Enter", "Other Criminal Violations - Offensive Weapons", "Drive While Disqualified"), n_obs, replace = TRUE),
    ARREST_COUNT = sample(1:50, n_obs, replace = TRUE)
  )
  
  return(data)
}

# Function to perform tests
perform_tests <- function(data) {
  # Test 1: Check if _id is sequential
  if (all(diff(data$`_id`) == 1)) {
    print("Test 1: _id is sequential - Passed")
  } else {
    print("Test 1: _id is not sequential - Failed")
  }
  
  # Test 2: Check for missing values
  if (any(is.na(data))) {
    print("Test 2: Missing values present - Failed")
  } else {
    print("Test 2: No missing values - Passed")
  }
}


# Simulate data
simulated_data <- simulate_data()

# Display the first few rows of the simulated data
print(head(simulated_data))
