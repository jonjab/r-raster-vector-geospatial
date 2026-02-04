# Episode 01: Open and Plot Vector Layers
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(tidyterra)
library(ggplot2)
library(dplyr)

# =============================================================================
# CHALLENGE: Import Line and Point Vector Layers
# =============================================================================

# Import the HARV_roads and HARVtower_UTM18N vector layers
lines_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
point_harv <- vect("site/built/data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

# Question 1: What type of R spatial object is created when you import each layer?
class(lines_harv)  # SpatVector
class(point_harv)  # SpatVector

# Question 2: What is the CRS and extent for each object?
crs(lines_harv)
ext(lines_harv)
crs(point_harv)
ext(point_harv)

# Question 3: Do the files contain points, lines, or polygons?
geomtype(lines_harv)  # lines
geomtype(point_harv)  # points

# Question 4: How many spatial objects are in each file?
# lines_harv contains 13 features (lines)
# point_harv contains 1 point
nrow(lines_harv)  # 13
nrow(point_harv)  # 1
