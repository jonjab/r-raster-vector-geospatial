# Episode 10: Work with Multi-Band Rasters
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(ggplot2)
library(dplyr)

# =============================================================================
# CHALLENGE: View attributes of single band
# =============================================================================

# Import single band
rgb_b_1_harv <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif",
                     lyrs = 1)

# View attributes
rgb_b_1_harv
# dimensions: 2317, 3073, 1 (nrow, ncol, nlyr)
# This tells us we read only one band

# =============================================================================
# CHALLENGE: NoData Values
# =============================================================================

# 1) View file attributes
describe("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_Ortho_wNA.tif")

# 2) What is the NoData Value?
# Answer: -9999

# 3) How many bands does it have?
# Answer: 3 bands

# 4) Load the multi-band raster file
harv_na <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_Ortho_wNA.tif")

# 5) Plot the object as true color image
plotRGB(harv_na, r = 1, g = 2, b = 3)

# 6) What happened to the black edges?
# Answer: The black edges are not plotted (rendered as NA)

# 7) What does this tell us about data structure differences?
# Both datasets have NoData values
# In RGB_stack: NoData not defined in tiff tags, rendered as black (reflectance = 0)
# In Ortho_wNA: NoData defined as -9999, rendered as NA
describe("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")

# =============================================================================
# CHALLENGE: What Functions Can Be Used on an R Object
# =============================================================================

# Import the full RGB stack
rgb_stack_harv <- rast("site/built/data/NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")

# 1) What methods can be used on rgb_stack_harv?
methods(class = class(rgb_stack_harv))

# 2) What methods can be used on a single band?
methods(class = class(rgb_stack_harv[[1]]))

# 3) Why is there no difference?
# Answer: A SpatRaster is the same no matter its number of bands
