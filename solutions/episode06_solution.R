# Episode 06: Intro to Raster Data
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(ggplot2)
library(dplyr)

# Load data
dsm_harv <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")
dsm_harv_df <- as.data.frame(dsm_harv, xy = TRUE)

# =============================================================================
# CHALLENGE: What units are our horizontal data in?
# =============================================================================

crs(dsm_harv, proj = TRUE)
# Answer: +units=m tells us that our data is in meters

# =============================================================================
# CHALLENGE: Explore Raster Metadata
# =============================================================================

# Use describe() to determine information about HARV_DSMhill.tif file
describe("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_DSMhill.tif")

# 1) If this file has the same CRS as dsm_harv?
# Answer: Yes, UTM Zone 18, WGS84, meters

# 2) What format NoDataValues take?
# Answer: -9999

# 3) The resolution of the raster data?
# Answer: 1x1

# 4) How large a 5x5 pixel area would be?
# Answer: 5m x 5m
# (We are given resolution of 1x1 and units in meters,
# therefore resolution of 5x5 means 5x5m)

# 5) Is the file a multi- or single-band raster?
# Answer: Single

# =============================================================================
# CHALLENGE: Use describe() to find NoDataValue
# =============================================================================

describe(sources(dsm_harv))
# NoDataValue are encoded as -9999
