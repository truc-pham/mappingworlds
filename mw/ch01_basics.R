# Session 1: R basics 
city <- "Ho Chi Minh City"
population_million <- 9.5
area_km2 <- 2095 

if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")

pacman::p_load(sf, terra, tidyverse)

packageVersion("sf")
sf::sf_extSoftVersion()