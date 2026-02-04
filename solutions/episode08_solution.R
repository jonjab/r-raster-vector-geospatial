# Episode 08: Reproject Raster Data
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(ggplot2)
library(dplyr)

# =============================================================================
# CHALLENGE: View CRS for DTM and DSM
# =============================================================================

# View the CRS for each dataset and check if they have the same CRS and resolution
describe("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")
describe("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")

# Both have the same CRS (UTM Zone 18N) and resolution (1m x 1m)

# =============================================================================
# CHALLENGE: Reproject, then Plot a Digital Surface Model
# =============================================================================

# Create a map of SJER using SJER_DSMhill_WGS84.tif and SJER_dsmCrop.tif
# Reproject data as necessary

# Import DSM
dsm_sjer <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_dsmCrop.tif")

# Import DSM hillshade
dsm_hill_wgs_sjer <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/SJER/DSM/SJER_DSMhill_WGS84.tif")

# Reproject raster
dsm_hill_utm_sjer <- project(dsm_hill_wgs_sjer,
                             crs(dsm_sjer),
                             res = 1)

# Convert to data.frames
dsm_sjer_df <- as.data.frame(dsm_sjer, xy = TRUE)
dsm_hill_sjer_df <- as.data.frame(dsm_hill_utm_sjer, xy = TRUE)

# Plot
ggplot() +
  geom_raster(data = dsm_hill_sjer_df,
              aes(x = x, y = y, alpha = SJER_DSMhill_WGS84)) +
  geom_raster(data = dsm_sjer_df,
              aes(x = x, y = y, fill = SJER_dsmCrop, alpha = 0.8)) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_quickmap()

# =============================================================================
# CHALLENGE: Plot Raster & Vector Data Together
# =============================================================================

# Plot vector data (AOI, roads, tower) on top of DTM with hillshade

# Import DTM
dtm_harv <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_dtmCrop.tif")

# Import DTM hillshade (in WGS84)
dtm_hill_harv_wgs <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/DTM/HARV_DTMhill_WGS84.tif")

# Reproject DTM hillshade to match DTM
dtm_hill_harv <- project(dtm_hill_harv_wgs, crs(dtm_harv), res = 1)

# Convert to data frames for ggplot
dtm_harv_df <- as.data.frame(dtm_harv, xy = TRUE)
dtm_hill_harv_df <- as.data.frame(dtm_hill_harv, xy = TRUE)

# Load vector data
aoi_boundary_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
lines_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
point_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

# Create plot
ggplot() +
  geom_raster(data = dtm_hill_harv_df,
              aes(x = x, y = y, alpha = HARV_DTMhill_WGS84)) +
  scale_alpha(range = c(0.15, 0.65), guide = "none") +
  geom_raster(data = dtm_harv_df,
              aes(x = x, y = y, fill = HARV_dtmCrop), alpha = 0.7) +
  scale_fill_viridis_c() +
  geom_spatvector(data = lines_harv, color = "black") +
  geom_spatvector(data = aoi_boundary_harv, color = "grey20", linewidth = 1.5,
                  fill = NA) +
  geom_spatvector(data = point_harv, color = "red", size = 3) +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "DTM with Hillshade and Site Features") +
  coord_sf()
