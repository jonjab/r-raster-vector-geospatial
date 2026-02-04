# Episode 04: Handling Spatial Projection & CRS
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(tidyterra)
library(ggplot2)
library(dplyr)

# Load data
aoi_boundary_harv <- vect("site/built/data/data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
lines_harv <- vect("site/built/data/data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
point_harv <- vect("site/built/data/data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

# =============================================================================
# CHALLENGE: Plot Multiple Layers of Spatial Data
# =============================================================================

# Import and plot Boundary-US-State-NEast.shp with tower location
ne_states_outline <- vect("../site/built/data/data/NEON-DS-Site-Layout-Files/US-Boundary-Layers/Boundary-US-State-NEast.shp")

# Create the plot with boundary, tower, title, and legend
ggplot() +
  geom_spatvector(data = ne_states_outline, aes(color = "color"),
                  show.legend = "line") +
  scale_color_manual(name = "", labels = "State Boundary",
                     values = c("color" = "gray18")) +
  geom_spatvector(data = point_harv, aes(shape = "shape"), color = "purple") +
  scale_shape_manual(name = "", labels = "Fisher Tower",
                     values = c("shape" = 19)) +
  ggtitle("Fisher Tower location") +
  theme(legend.background = element_rect(color = NA)) +
  coord_sf()
