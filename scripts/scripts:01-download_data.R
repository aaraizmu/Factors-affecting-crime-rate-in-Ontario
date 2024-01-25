#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Muhammad Aaraiz
# Date: 24 January 2024
# Contact: muhammad.aaraiz@mail.utoronto.ca
# License: MIT
# Pre-requisites: Make sure readr and httr packages are installed.
# Any other information needed? None

#### Workspace setup ####
# Load necessary libraries
library(readr)
library(httr)
# ... ADDITIONAL LIBRARIES ...

#### Download data ####
# Specify the dataset URL from Open Data Toronto
dataset_url <- "https://open.toronto.ca/dataset/police-annual-statistical-report-arrested-and-charged-persons/"  # Update with the correct dataset URL

# Download the data
response <- httr::GET(dataset_url)
content <- httr::content(response, "text", encoding = "UTF-8")

# Save the data to a CSV file named "unedited_data.csv"
writeLines(content, "unedited_data.csv")




