#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Muhammad Aaraiz
# Date: 24 Janaury 2024
# Contact: muhammad.aaraiz@mail.utoronto.ca
# License: MIT
# Pre-requisites: Make sure dplyr, testthat and ggplot2 packages are installed.
# Load necessary libraries

# Load necessary libraries
library(testthat)
library(dplyr)
library(ggplot2)


# Function to test the cleaned data
test_cleaned_data <- function(cleaned_data) {
  
  # Test 1: Check for missing values
  test_that("No missing values in the cleaned data", {
    expect_false(any(is.na(cleaned_data)))
  })
  
  # Test 2: Check the number of observations
  test_that("Correct number of observations", {
    expect_equal(nrow(cleaned_data), expected_number_of_observations)
  })
  
  # Test 3: Check the number of variables
  test_that("Correct number of variables", {
    expect_equal(ncol(cleaned_data), expected_number_of_variables)
  })
  
  # Test 4: Check for duplicates
  test_that("No duplicate rows in the cleaned data", {
    expect_equal(duplicated(cleaned_data), rep(FALSE, nrow(cleaned_data)))
  })
  
  # Test 5: Check for specific boundary conditions
  
  # Example: Check if ARREST_YEAR is within a specific range
  test_that("ARREST_YEAR is within the expected range", {
    expect_true(all(cleaned_data$ARREST_YEAR >= lower_bound_ARREST_YEAR &
                      cleaned_data$ARREST_YEAR <= upper_bound_ARREST_YEAR))
  })
  # Test Linear Regression Model on cleaned_data
  test_that("Linear regression model runs successfully", {
    # Specify your predictor variables from cleaned_data
    predictors <- c("arrest_year", "age_group")
    
    # Ensure the response variable is present in the dataset
    expect_true("arrest_count" %in% colnames(cleaned_data))
    
    # Build the formula
    formula <- as.formula(paste("arrest_count ~", paste(predictors, collapse = " + ")))
    
    # Fit the linear regression model on cleaned_data
    lm_model <- try(lm(formula, data = cleaned_data), silent = TRUE)
    
    # Check if the model runs successfully
    expect_true(!inherits(lm_model, "try-error"))
  })
  
  
}

# Define expected values
expected_number_of_observations <- 129374
expected_number_of_variables <-  10
lower_bound_ARREST_YEAR <-  2014
upper_bound_ARREST_YEAR <-  2022

# Apply the tests to the cleaned data
test_cleaned_data(cleaned_full_data)

# Descriptive Test: Arrest Count per Year
test_that("Arrest Count per Year", {
  expect_true("arrest_year" %in% colnames(cleaned_full_data))
  
  # Descriptive statistics
  summary_stats <- cleaned_full_data %>%
    group_by(arrest_year) %>%
    summarise(mean_arrests = mean(arrest_count),
              median_arrests = median(arrest_count),
              total_arrests = sum(arrest_count))
  
  # Plotting
  ggplot(summary_stats, aes(x = arrest_year, y = total_arrests)) +
    geom_bar(stat = "identity", fill = "skyblue", color = "black") +
    labs(title = "Arrest Count per Year",
         x = "Year",
         y = "Total Arrests")
})

# Descriptive Test: Arrest Count for Different Sex
test_that("Arrest Count for Different Sex", {
  expect_true("sex" %in% colnames(cleaned_full_data))
  
  # Descriptive statistics
  summary_stats <- cleaned_full_data %>%
    group_by(sex) %>%
    summarise(total_arrests = sum(arrest_count))
  
  # Plotting
  ggplot(summary_stats, aes(x = sex, y = total_arrests)) +
    geom_bar(stat = "identity", fill = "pink", color = "black") +
    labs(title = "Arrest Count for Different Sex",
         x = "Sex",
         y = "Total Arrests")
})

# Descriptive Test: Arrest Count for Different Age Cohort
test_that("Arrest Count for Different Age Cohort", {
  expect_true("age_cohort" %in% colnames(cleaned_full_data))
  
  # Descriptive statistics
  summary_stats <- cleaned_full_data %>%
    group_by(age_cohort) %>%
    summarise(total_arrests = sum(arrest_count))
  
  # Plotting
  ggplot(summary_stats, aes(x = age_cohort, y = total_arrests)) +
    geom_bar(stat = "identity", fill = "lightgreen", color = "black") +
    labs(title = "Arrest Count for Different Age Cohort",
         x = "Age Cohort",
         y = "Total Arrests")
})





