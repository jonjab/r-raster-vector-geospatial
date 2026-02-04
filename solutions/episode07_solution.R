# Episode 07: Plot Raster Data
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
# CHALLENGE: Plot Using Custom Breaks
# =============================================================================

# Create a plot with:
# 1) Six classified ranges of values
# 2) Axis labels
# 3) A plot title

dsm_harv_df <- dsm_harv_df %>%
  mutate(fct_elevation_6 = cut(HARV_dsmCrop, breaks = 6))

my_colors <- terrain.colors(6)

ggplot() +
  geom_raster(data = dsm_harv_df, aes(x = x, y = y, fill = fct_elevation_6)) +
  scale_fill_manual(values = my_colors, name = "Elevation") +
  ggtitle("Classified Elevation Map - NEON Harvard Forest Field Site") +
  xlab("UTM Easting Coordinate (m)") +
  ylab("UTM Northing Coordinate (m)") +
  coord_quickmap()

# =============================================================================
# CHALLENGE: Create DTM & DSM for SJER
# =============================================================================

# Create Digital Terrain Model and Digital Surface Model maps for SJER
# with hillshade, labels, titles, and various alpha values

# CREATE DSM MAPS
# Import DSM data
dsm_sjer <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_dsmCrop.tif")
dsm_sjer_df <- as.data.frame(dsm_sjer, xy = TRUE)

# Import DSM hillshade
dsm_hill_sjer <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_dsmHill.tif")
dsm_hill_sjer_df <- as.data.frame(dsm_hill_sjer, xy = TRUE)

# Build Plot
ggplot() +
  geom_raster(data = dsm_sjer_df,
              aes(x = x, y = y, fill = SJER_dsmCrop, alpha = 0.8)) +
  geom_raster(data = dsm_hill_sjer_df,
              aes(x = x, y = y, alpha = SJER_dsmHill)) +
  scale_fill_viridis_c() +
  guides(fill = guide_colorbar()) +
  scale_alpha(range = c(0.4, 0.7), guide = "none") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  xlab("UTM Easting Coordinate (m)") +
  ylab("UTM Northing Coordinate (m)") +
  ggtitle("DSM with Hillshade") +
  coord_quickmap()

# CREATE DTM MAP
# Import DTM
dtm_sjer <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/SJER/DTM/SJER_dtmCrop.tif")
dtm_sjer_df <- as.data.frame(dtm_sjer, xy = TRUE)

# DTM Hillshade
dtm_hill_sjer <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/SJER/DTM/SJER_dtmHill.tif")
dtm_hill_sjer_df <- as.data.frame(dtm_hill_sjer, xy = TRUE)

ggplot() +
  geom_raster(data = dtm_sjer_df,
              aes(x = x, y = y, fill = SJER_dtmCrop, alpha = 2.0)) +
  geom_raster(data = dtm_hill_sjer_df,
              aes(x = x, y = y, alpha = SJER_dtmHill)) +
  scale_fill_viridis_c() +
  guides(fill = guide_colorbar()) +
  scale_alpha(range = c(0.4, 0.7), guide = "none") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  ggtitle("DTM with Hillshade") +
  coord_quickmap()
