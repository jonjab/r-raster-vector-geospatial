# Episode 02: Explore and Plot by Vector Layer Attributes
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

# =============================================================================
# CHALLENGE: Attributes for Different Spatial Classes
# =============================================================================

# 1) How many attributes does each have?
ncol(point_harv)  # 14
ncol(aoi_boundary_harv)  # 1

# 2) Who owns the site in the point_harv data object?
point_harv$Ownership  # "Harvard University"

# 3) Which of the following is NOT an attribute of the point_harv data object?
# A) Latitude  B) County  C) Country
names(point_harv)
# Answer: C) Country is NOT an attribute

# =============================================================================
# CHALLENGE: Subset Spatial Line Objects Part 1
# =============================================================================

# Subset out all boardwalk from the lines layer and plot it
boardwalk_harv <- lines_harv %>%
  filter(TYPE == "boardwalk")

# Check how many features
nrow(boardwalk_harv)  # 1

# Plot the data
ggplot() +
  geom_spatvector(data = boardwalk_harv, linewidth = 1.5) +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Boardwalks") +
  coord_sf()

# =============================================================================
# CHALLENGE: Subset Spatial Line Objects Part 2
# =============================================================================

# Subset out all stone wall features and plot with unique colors
stonewall_harv <- lines_harv %>%
  filter(TYPE == "stone wall")

# Check number of features
nrow(stonewall_harv)  # 5

# Plot the data with each feature colored differently
ggplot() +
  geom_spatvector(data = stonewall_harv, aes(color = factor(OBJECTID)), linewidth = 1.5) +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Stonewalls") +
  coord_sf()

# =============================================================================
# CHALLENGE: Plot Line Width by Attribute
# =============================================================================

# Create plot with specific thicknesses:
# woods road = 6, boardwalks = 1, footpath = 3, stone wall = 2

# First check the order of types
unique(lines_harv$TYPE)  # "boardwalk" "footpath" "stone wall" "woods road"

# Create line_width vector in the correct order
line_width <- c(1, 3, 2, 6)

# Create plot
ggplot() +
  geom_spatvector(data = lines_harv, aes(linewidth = TYPE)) +
  scale_linewidth_manual(values = line_width) +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads & Trails - Line width varies") +
  coord_sf()

# =============================================================================
# CHALLENGE: Plot Lines by Attribute
# =============================================================================

# Emphasize roads where bicycles and horses are allowed

# Explore the BicyclesHo attribute
lines_harv %>%
  pull(BicyclesHo) %>%
  unique()

# Create subset
roads_bike_horse <- lines_harv %>%
  filter(BicyclesHo == "Bicycles and Horses Allowed")

# Plot with emphasis on bike/horse roads
ggplot() +
  geom_spatvector(data = lines_harv) +
  geom_spatvector(data = roads_bike_horse, aes(color = BicyclesHo), linewidth = 2) +
  scale_color_manual(values = "magenta") +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Roads Where Bikes and Horses Are Allowed") +
  coord_sf()

# =============================================================================
# CHALLENGE: Plot Polygon by Attribute
# =============================================================================

# Create a map of state boundaries colored by region
state_boundary_us <- vect("site/built/data/NEON-DS-Site-Layout-Files/US-Boundary-Layers/US-State-Boundaries-Census-2014.shp")

# Convert region to factor and check levels
state_boundary_us$region <- as.factor(state_boundary_us$region)
levels(state_boundary_us$region)  # 5 regions

# Create color vector
colors <- c("purple", "springgreen", "yellow", "brown", "navy")

# Create plot
ggplot() +
  geom_spatvector(data = state_boundary_us, aes(color = region), linewidth = 1) +
  scale_color_manual(values = colors) +
  ggtitle("Contiguous U.S. State Boundaries") +
  coord_sf()
