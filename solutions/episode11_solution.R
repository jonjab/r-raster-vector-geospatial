# Episode 11: Manipulate Raster Data
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(tidyterra)
library(ggplot2)
library(dplyr)

# Load data
point_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")
lines_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
aoi_boundary_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
chm_harv <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/CHM/HARV_chmCrop.tif")
plot_locations_harv <- read.csv("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARV_PlotLocations.csv")
utm_18n_crs <- crs(point_harv)
plot_locations_sp_harv <- vect(plot_locations_harv,
                               geom = c("easting", "northing"),
                               crs = utm_18n_crs)

# =============================================================================
# CHALLENGE: Crop to Vector Points Extent
# =============================================================================

# 1) Crop the CHM to extent of study plot locations
chm_crop_p_harv <- crop(x = chm_harv, y = plot_locations_sp_harv)

# 2) Plot vegetation plot locations on top of CHM
ggplot() +
  geom_spatraster(data = chm_crop_p_harv) +
  scale_fill_gradientn(name = "Canopy Height", colors = terrain.colors(10)) +
  geom_spatvector(data = plot_locations_sp_harv) +
  coord_sf()

# =============================================================================
# CHALLENGE: Extract Raster Height Values For Plot Locations
# =============================================================================

# 1) Extract average tree height for 20m around each plot location
avg_tree_ht_p <- extract(x = chm_harv,
                         y = buffer(plot_locations_sp_harv, dist = 20),
                         fun = mean)

# View data
avg_tree_ht_p

# 2) Create a plot showing mean tree height of each area
ggplot(data = avg_tree_ht_p, aes(ID, HARV_chmCrop)) +
  geom_col() +
  ggtitle("Mean Tree Height at each Plot") +
  xlab("Plot ID") +
  ylab("Tree Height (m)")
