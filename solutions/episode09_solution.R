# Episode 09: Raster Calculations
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
dtm_harv <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")
dtm_harv_df <- as.data.frame(dtm_harv, xy = TRUE)
dsm_sjer <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_dsmCrop.tif")
dsm_sjer_df <- as.data.frame(dsm_sjer, xy = TRUE)
dtm_sjer <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/SJER/DTM/SJER_dtmCrop.tif")
dtm_sjer_df <- as.data.frame(dtm_sjer, xy = TRUE)

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
chm_harv_df <- as.data.frame(chm_harv, xy = TRUE)

# 1) What is the min and maximum value for the CHM?
min(chm_harv_df$HARV_dsmCrop, na.rm = TRUE)  # 0
max(chm_harv_df$HARV_dsmCrop, na.rm = TRUE)  # 38.17

# 2) What are two ways to check this range?
# - Create a histogram
# - Use min(), max(), and range() functions
# - Print the object and look at values attribute

# 3) What is the distribution of all pixel values in the CHM?
ggplot(chm_harv_df) +
  geom_histogram(aes(HARV_dsmCrop))

# 4) Plot histogram with 6 bins and different color
ggplot(chm_harv_df) +
  geom_histogram(aes(HARV_dsmCrop), colour = "black",
                 fill = "darkgreen", bins = 6)

# 5) Plot the chm_harv raster using breaks
custom_bins <- c(0, 10, 20, 30, 40)
chm_harv_df <- chm_harv_df %>%
  mutate(canopy_discrete = cut(HARV_dsmCrop, breaks = custom_bins))

ggplot() +
  geom_raster(data = chm_harv_df, aes(x = x, y = y, fill = canopy_discrete)) +
  scale_fill_manual(values = terrain.colors(4)) +
  coord_quickmap()

# =============================================================================
# CHALLENGE: Explore the NEON San Joaquin Experimental Range Field Site
# =============================================================================

# 1) Create CHM from DSM and DTM for SJER
chm_ov_sjer <- lapp(sds(list(dsm_sjer, dtm_sjer)),
                    fun = function(r1, r2) { return(r1 - r2) })

# Convert to dataframe
chm_ov_sjer_df <- as.data.frame(chm_ov_sjer, xy = TRUE)

# Check distribution with histogram
ggplot(chm_ov_sjer_df) +
  geom_histogram(aes(SJER_dsmCrop))

# 2) Plot the CHM
ggplot() +
  geom_raster(data = chm_ov_sjer_df,
              aes(x = x, y = y, fill = SJER_dsmCrop)) +
  scale_fill_gradientn(name = "Canopy Height",
                       colors = terrain.colors(10)) +
  coord_quickmap()

# 3) Export the SJER CHM as a GeoTIFF
writeRaster(chm_ov_sjer, "chm_ov_sjer.tiff",
            filetype = "GTiff",
            overwrite = TRUE,
            NAflag = -9999)

# 4) Compare SJER and HARV CHMs
# Tree heights are much shorter in SJER
# Confirmed by comparing histograms
ggplot(chm_harv_df) +
  geom_histogram(aes(HARV_dsmCrop))

ggplot(chm_ov_sjer_df) +
  geom_histogram(aes(SJER_dsmCrop))
