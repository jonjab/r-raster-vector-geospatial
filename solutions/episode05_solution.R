# Episode 05: Convert from .csv to a Vector Layer
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(tidyterra)
library(ggplot2)
library(dplyr)

# Load data that learners should have from previous episodes
lines_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
aoi_boundary_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
us_outline <- vect("site/built/data/NEON-DS-Site-Layout-Files/US-Boundary-Layers/US-Boundary-Dissolved-States.shp")
point_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

# Create the main dataset from the episode
plot_locations_harv <- read.csv("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARV_PlotLocations.csv")
utm_18n_crs <- crs(point_harv)
plot_locations_sp_harv <- vect(plot_locations_harv,
                               geom = c("easting", "northing"),
                               crs = utm_18n_crs)

# =============================================================================
# CHALLENGE: Import & Plot Additional Points
# =============================================================================

# Import the .csv: HARV/HARV_2NewPhenPlots.csv

# 1) Find the X and Y coordinate locations
newplot_locations_harv <- read.csv("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARV_2NewPhenPlots.csv")
str(newplot_locations_harv)
# X = decimalLon, Y = decimalLat

# 2) Convert dataframe to spatial object (WGS84 geographic CRS)
wgs_84_crs <- crs(us_outline)
wgs_84_crs  # Confirm it's WGS84

newplot_sp_harv <- vect(newplot_locations_harv,
                        geom = c("decimalLon", "decimalLat"),
                        crs = wgs_84_crs)

# Confirm CRS
crs(newplot_sp_harv)

# 3) Plot the new points with different symbol
ggplot() +
  geom_spatvector(data = plot_locations_sp_harv, color = "orange") +
  geom_spatvector(data = newplot_sp_harv, color = "lightblue") +
  ggtitle("Map of All Plot Locations")

