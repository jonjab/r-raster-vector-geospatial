# Episode 09: Raster Calculations
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(ggplot2)
library(dplyr)
library(tidyterra)

# Load data
dsm_harv <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")
dtm_harv <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")
dsm_sjer <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_dsmCrop.tif")
dtm_sjer <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/SJER/DTM/SJER_dtmCrop.tif")

# =============================================================================
# CHALLENGE: Use describe() to view DTM and DSM information
# =============================================================================

describe("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")
describe("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")

# Both have the same CRS and resolution
# Both have defined min and max values

# =============================================================================
# CHALLENGE: Explore CHM Raster Values
# =============================================================================

# Create CHM from DSM and DTM
chm_harv <- dsm_harv - dtm_harv

# 1) What is the min and maximum value for the CHM?
min(values(chm_harv), na.rm = TRUE)  # 0
max(values(chm_harv), na.rm = TRUE)  # 38.17

# 2) What are two ways to check this range?
# - Create a histogram
# - Use min(), max(), and range() functions
# - Print the object and look at values attribute

# 3) What is the distribution of all pixel values in the CHM?
ggplot() +
  geom_histogram(data = chm_harv, aes(x = HARV_dsmCrop))

# 4) Plot histogram with 6 bins and different color
ggplot() +
  geom_histogram(data = chm_harv, aes(x = HARV_dsmCrop),
                 colour = "black", fill = "darkgreen", bins = 6)

# 5) Plot the chm_harv raster using breaks
custom_bins <- c(0, 10, 20, 30, 40)
# Create classification matrix
class_matrix <- matrix(c(0, 10, 1,
                         10, 20, 2,
                         20, 30, 3,
                         30, 40, 4),
                       ncol = 3, byrow = TRUE)
chm_harv_discrete <- classify(chm_harv, class_matrix)

ggplot() +
  geom_spatraster(data = chm_harv_discrete) +
  scale_fill_gradientn(colors = terrain.colors(4)) +
  coord_sf()

# =============================================================================
# CHALLENGE: Explore the NEON San Joaquin Experimental Range Field Site
# =============================================================================

# 1) Create CHM from DSM and DTM for SJER
chm_sjer <- dsm_sjer - dtm_sjer


# Check distribution with histogram
ggplot() +
  geom_histogram(data = chm_sjer, aes(x = SJER_dsmCrop))

# 2) Plot the CHM
ggplot() +
  geom_spatraster(data = chm_sjer) +
  scale_fill_gradientn(name = "Canopy Height",
                       colors = terrain.colors(10)) +
  coord_sf()

# 3) Export the SJER CHM as a GeoTIFF
writeRaster(chm_sjer, "chm_ov_sjer.tiff",
            filetype = "GTiff",
            overwrite = TRUE,
            NAflag = -9999)

# 4) Compare SJER and HARV CHMs
# Tree heights are much shorter in SJER
# Confirmed by comparing histograms
ggplot() +
  geom_histogram(data = chm_harv, aes(x = HARV_dsmCrop))

ggplot() +
  geom_histogram(data = chm_sjer, aes(x = SJER_dsmCrop))
