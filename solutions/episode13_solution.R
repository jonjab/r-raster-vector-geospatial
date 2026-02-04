# Episode 13: Create Publication-quality Graphics
# Solutions for Challenges

# Clear environment
rm(list = ls())

# Load libraries
library(terra)
library(ggplot2)
library(dplyr)
library(reshape)
library(RColorBrewer)
library(scales)

# Load and prepare data
all_ndvi_harv <- list.files("site/built/data/NEON-DS-Landsat-NDVI/HARV/2011/NDVI",
                            full.names = TRUE, pattern = ".tif$")
ndvi_harv_stack <- rast(all_ndvi_harv)
names(ndvi_harv_stack) <- paste0("X", names(ndvi_harv_stack))
ndvi_harv_stack <- ndvi_harv_stack / 10000
ndvi_harv_stack_df <- as.data.frame(ndvi_harv_stack, xy = TRUE) %>%
  melt(id.vars = c('x', 'y'))

# =============================================================================
# CHALLENGE: Make plot title bold
# =============================================================================

ggplot() +
  geom_raster(data = ndvi_harv_stack_df,
              aes(x = x, y = y, fill = value)) +
  facet_wrap(~ variable) +
  ggtitle("Landsat NDVI", subtitle = "NEON Harvard Forest") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5))

# =============================================================================
# CHALLENGE: Divergent Color Ramps
# =============================================================================

# Update labels to "Julian Day" and use divergent color ramp

raster_names <- names(ndvi_harv_stack)
raster_names <- gsub("_HARV_ndvi_crop", "", raster_names)
raster_names <- gsub("X", "Julian Day ", raster_names)
labels_names <- setNames(raster_names, unique(ndvi_harv_stack_df$variable))

# Create brown to green divergent color ramp
brown_green_colors <- colorRampPalette(brewer.pal(9, "BrBG"))

ggplot() +
  geom_raster(data = ndvi_harv_stack_df, aes(x = x, y = y, fill = value)) +
  facet_wrap(~variable, ncol = 5, labeller = labeller(variable = labels_names)) +
  ggtitle("Landsat NDVI - Julian Days", subtitle = "Harvard Forest 2011") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5)) +
  scale_fill_gradientn(name = "NDVI", colours = brown_green_colors(20))

# For NDVI data, the sequential color ramp is better than divergent
# as it represents the process of greening up more naturally.
