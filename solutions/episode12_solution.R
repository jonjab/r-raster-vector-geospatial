# Episode 12: Raster Time Series Data
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(ggplot2)
library(dplyr)
library(scales)
library(tidyr)

# Load data
ndvi_harv_path <- "site/built/data/NEON-DS-Landsat-NDVI/HARV/2011/NDVI"
all_ndvi_harv <- list.files(ndvi_harv_path,
                            full.names = TRUE,
                            pattern = ".tif$")
ndvi_harv_stack <- rast(all_ndvi_harv)
names(ndvi_harv_stack) <- paste0("X", names(ndvi_harv_stack))
ndvi_harv_stack <- ndvi_harv_stack / 10000

# =============================================================================
# CHALLENGE: Raster Metadata
# =============================================================================

# 1) What are the x and y resolution of the data?
ext(ndvi_harv_stack)
yres(ndvi_harv_stack)  # 30
xres(ndvi_harv_stack)  # 30

# 2) What units are the resolution in?
# Answer: meters (from the CRS information)
crs(ndvi_harv_stack, proj = TRUE)

# =============================================================================
# CHALLENGE: Examine RGB Raster Files
# =============================================================================

# Plot RGB images for Julian days 277 and 293

# JULIAN DAY 277
rgb_277 <- rast("site/built/data/NEON-DS-Landsat-NDVI/HARV/2011/RGB/277_HARV_landRGB.tif")
names(rgb_277) <- paste0("X", names(rgb_277))  # Fix names
rgb_277
rgb_277 <- rgb_277 / 255  # Scale to 0-1
rgb_277_df <- as.data.frame(rgb_277, xy = TRUE)
rgb_277_df$rgb <- with(rgb_277_df, rgb(X277_HARV_landRGB_1,
                                       X277_HARV_landRGB_2,
                                       X277_HARV_landRGB_3, 1))

ggplot() +
  geom_raster(data = rgb_277_df, aes(x, y), fill = rgb_277_df$rgb) +
  ggtitle("Julian day 277")

# JULIAN DAY 293
rgb_293 <- rast("site/built/data/NEON-DS-Landsat-NDVI/HARV/2011/RGB/293_HARV_landRGB.tif")
names(rgb_293) <- paste0("X", names(rgb_293))
rgb_293 <- rgb_293 / 255
rgb_293_df <- as.data.frame(rgb_293, xy = TRUE)
rgb_293_df$rgb <- with(rgb_293_df, rgb(X293_HARV_landRGB_1,
                                       X293_HARV_landRGB_2,
                                       X293_HARV_landRGB_3, 1))

ggplot() +
  geom_raster(data = rgb_293_df, aes(x, y), fill = rgb_293_df$rgb) +
  ggtitle("Julian day 293")

# The RGB imagery shows that most of the images for days 277 and 293
# are filled with clouds. The very low NDVI values resulted from cloud cover.
