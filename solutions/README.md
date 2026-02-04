# Solutions for r-raster-vector-geospatial Lessons

This directory contains R script solutions for all 14 episodes of the "Introduction to Geospatial Raster and Vector Data with R" lesson.

## File Structure

Each episode has its own solution file:
- `episode01_solution.R` - Open and Plot Vector Layers
- `episode02_solution.R` - Explore and Plot by Vector Layer Attributes
- `episode03_solution.R` - Plot Multiple Vector Layers
- `episode04_solution.R` - Handling Spatial Projection & CRS
- `episode05_solution.R` - Convert from .csv to a Vector Layer
- `episode06_solution.R` - Intro to Raster Data
- `episode07_solution.R` - Plot Raster Data
- `episode08_solution.R` - Reproject Raster Data
- `episode09_solution.R` - Raster Calculations
- `episode10_solution.R` - Work with Multi-Band Rasters
- `episode11_solution.R` - Manipulate Raster Data
- `episode12_solution.R` - Raster Time Series Data
- `episode13_solution.R` - Create Publication-quality Graphics
- `episode14_solution.R` - Derive Values from Raster Time Series

## What's in Each File

Each solution file contains:

1. **Environment clearing**: Starts with `rm(list = ls())` to clear the R environment
2. **Library loading**: Loads all necessary packages for that episode
3. **Challenge solutions**: Clearly marked sections for each challenge in the episode

## How to Use

### Running a Complete Episode Solution

To run all solutions for a specific episode:

```r
source("solutions/episode01_solution.R")
```

### Running Individual Challenges

You can copy and paste individual challenge sections from the solution files into your R console or script.

### Prerequisites

Before running these solutions, make sure you have:

1. Completed the data setup:
   ```r
   source("episodes/setup.R")
   ```

2. Installed all required packages:
   - `terra`
   - `tidyterra`
   - `ggplot2`
   - `dplyr`
   - `RColorBrewer` (for episodes 13-14)
   - `reshape` (for episodes 13-14)
   - `scales` (for episodes 12-14)
   - `tidyr` (for episode 12)

## Important Notes

- **Data paths**: Solutions use relative paths (`../episodes/data/`) that work when sourcing files from the `solutions/` directory
- **Challenge sections**: Look for comments starting with `# CHALLENGE:` to identify where each challenge solution begins
- **Dependencies**: Some episodes build on data loaded in previous episodes. If you encounter errors, you may need to run earlier episode solutions first.

## For Instructors

These solution files can be used:
- As answer keys when teaching the lesson
- To verify your own approach to the challenges
- To quickly demonstrate solutions during workshops
- As starting points for creating additional exercises

## Contributing

If you find errors in the solutions or have suggestions for improvements, please open an issue or pull request in the main repository.
