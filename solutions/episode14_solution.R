# Episode 14: Derive Values from Raster Time Series
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(ggplot2)
library(dplyr)

# Load and prepare HARV data
all_ndvi_harv <- list.files("site/built/data/NEON-DS-Landsat-NDVI/HARV/2011/NDVI",
                            full.names = TRUE,
                            pattern = ".tif$")
ndvi_harv_stack <- rast(all_ndvi_harv)
names(ndvi_harv_stack) <- paste0("X", names(ndvi_harv_stack))
ndvi_harv_stack <- ndvi_harv_stack / 10000

# Calculate average NDVI for HARV
avg_ndvi_harv <- as.data.frame(global(ndvi_harv_stack, mean))
names(avg_ndvi_harv) <- "meanNDVI"
avg_ndvi_harv$site <- "HARV"
avg_ndvi_harv$year <- "2011"
julian_days <- gsub("X|_HARV_ndvi_crop", "", row.names(avg_ndvi_harv))
avg_ndvi_harv$julianDay <- as.integer(julian_days)
origin <- as.Date("2011-01-01")
avg_ndvi_harv$Date <- origin + (avg_ndvi_harv$julianDay - 1)

# =============================================================================
# CHALLENGE: NDVI for San Joaquin Experimental Range
# =============================================================================

# Create dataframe with mean NDVI values and Julian days for SJER

# Read in NDVI data for SJER
ndvi_path_sjer <- "site/built/data/NEON-DS-Landsat-NDVI/SJER/2011/NDVI"
all_ndvi_sjer <- list.files(ndvi_path_sjer,
                            full.names = TRUE,
                            pattern = ".tif$")
ndvi_stack_sjer <- rast(all_ndvi_sjer)
names(ndvi_stack_sjer) <- paste0("X", names(ndvi_stack_sjer))
ndvi_stack_sjer <- ndvi_stack_sjer / 10000

# Calculate mean values
avg_ndvi_sjer <- as.data.frame(global(ndvi_stack_sjer, mean))

# Rename column and add site/year
names(avg_ndvi_sjer) <- "meanNDVI"
avg_ndvi_sjer$site <- "SJER"
avg_ndvi_sjer$year <- "2011"

# Create Julian day column
julian_days_sjer <- gsub("X|_SJER_ndvi_crop", "", row.names(avg_ndvi_sjer))
origin <- as.Date("2011-01-01")
avg_ndvi_sjer$julianDay <- as.integer(julian_days_sjer)
avg_ndvi_sjer$Date <- origin + (avg_ndvi_sjer$julianDay - 1)

head(avg_ndvi_sjer)

# =============================================================================
# CHALLENGE: Plot San Joaquin Experimental Range Data
# =============================================================================

# Create plot for SJER data with different color
ggplot(avg_ndvi_sjer, aes(julianDay, meanNDVI)) +
  geom_point(colour = "SpringGreen4") +
  ggtitle("Landsat Derived NDVI - 2011", subtitle = "NEON SJER Field Site") +
  xlab("Julian Day") + ylab("Mean NDVI")

# =============================================================================
# CHALLENGE: Plot NDVI with date
# =============================================================================

# Plot SJER and HARV data using Date on x-axis
ndvi_harv_sjer <- rbind(avg_ndvi_harv, avg_ndvi_sjer)

ggplot(ndvi_harv_sjer, aes(x = Date, y = meanNDVI, colour = site)) +
  geom_point(aes(group = site)) +
  geom_line(aes(group = site)) +
  ggtitle("Landsat Derived NDVI - 2011",
          subtitle = "Harvard Forest vs San Joaquin") +
  xlab("Date") + ylab("Mean NDVI")

# =============================================================================
# CHALLENGE: Write to .csv
# =============================================================================

# 1) Create NDVI .csv file for SJER
filtered_avg_ndvi_sjer <- subset(avg_ndvi_sjer, meanNDVI > 0.1)
row.names(filtered_avg_ndvi_sjer) <- NULL
head(filtered_avg_ndvi_sjer)
write.csv(filtered_avg_ndvi_sjer, file = "meanNDVI_SJER_2011.csv")

# 2) Create NDVI .csv file for both sites
filtered_avg_ndvi_harv <- subset(avg_ndvi_harv, meanNDVI > 0.1)
row.names(filtered_avg_ndvi_harv) <- NULL
ndvi_both_sites <- rbind(filtered_avg_ndvi_harv, filtered_avg_ndvi_sjer)
write.csv(ndvi_both_sites, file = "meanNDVI_HARV_SJER_2011.csv")
