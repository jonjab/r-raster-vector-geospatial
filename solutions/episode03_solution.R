# Episode 03: Plot Multiple Vector Layers
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(tidyterra)
library(ggplot2)
library(dplyr)

# Load data
aoi_boundary_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
lines_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
point_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")
chm_harv <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/CHM/HARV_chmCrop.tif")
chm_harv_df <- as.data.frame(chm_harv, xy = TRUE)
road_colors <- c("blue", "green", "navy", "purple")

# =============================================================================
# CHALLENGE: Plot Polygon by Attribute
# =============================================================================

# Create a map of study plot locations colored by soil type
plot_locations <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/PlotLocations_HARV.shp")

# Convert soilTypeOr to factor
plot_locations$soilTypeOr <- as.factor(plot_locations$soilTypeOr)
levels(plot_locations$soilTypeOr)  # 2 soil types

# Create color palette
blue_orange <- c("cornflowerblue", "darkorange")

# Create plot
ggplot() +
  geom_spatvector(data = lines_harv, aes(color = TYPE), show.legend = "line") +
  geom_spatvector(data = plot_locations, aes(fill = soilTypeOr),
                  shape = 21, show.legend = 'point') +
  scale_color_manual(name = "Line Type", values = road_colors,
                     guide = guide_legend(override.aes = list(linetype = "solid",
                                                              shape = NA))) +
  scale_fill_manual(name = "Soil Type", values = blue_orange,
                    guide = guide_legend(override.aes = list(linetype = "blank",
                                                             shape = 21,
                                                             colour = "black"))) +
  ggtitle("NEON Harvard Forest Field Site") +
  coord_sf()

# Part 2: Plot with different symbols for each soil type
ggplot() +
  geom_spatvector(data = lines_harv, aes(color = TYPE), show.legend = "line", size = 1) +
  geom_spatvector(data = plot_locations, aes(fill = soilTypeOr, shape = soilTypeOr),
                  show.legend = 'point', size = 3) +
  scale_shape_manual(name = "Soil Type", values = c(21, 22)) +
  scale_color_manual(name = "Line Type", values = road_colors,
                     guide = guide_legend(override.aes = list(linetype = "solid",
                                                              shape = NA))) +
  scale_fill_manual(name = "Soil Type", values = blue_orange,
                    guide = guide_legend(override.aes = list(linetype = "blank",
                                                             shape = c(21, 22),
                                                             color = "black"))) +
  ggtitle("NEON Harvard Forest Field Site") +
  coord_sf()
