#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Muhammad Aaraiz
# Date: 24 Janaury 2024
# Contact: muhammad.aaraiz@mail.utoronto.ca
# License: MIT
# Pre-requisites: Make sure tidyverse and janitor packages are installed.
# Load necessary libraries

library(tidyverse)
library(janitor)

# Read the raw data from the CSV file
raw_data <- read.csv("Arrested and Charged Persons.csv")

# Function to clean the data
clean_data <- function(raw_data) {
  cleaned_data <- raw_data %>%
    mutate(
      NEIGHBOURHOOD_158 = gsub("'", "", NEIGHBOURHOOD_158),  # Remove single quotes from NEIGHBOURHOOD_158
      ARREST_YEAR = as.integer(ARREST_YEAR),  # Convert ARREST_YEAR to integer
      ARREST_COUNT = as.integer(ARREST_COUNT)  # Convert ARREST_COUNT to integer
    ) %>%
    janitor::clean_names() %>%
    select(-matches("^X_id$"))  # Drop the automatically generated index column (X_id)
  
  return(cleaned_data)
}

# Apply cleaning function to the entire dataset
cleaned_full_data <- clean_data(raw_data)

# Display the cleaned data
print(cleaned_full_data)



