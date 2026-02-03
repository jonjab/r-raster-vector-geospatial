# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**This is a fork** of the Data Carpentry lesson "Introduction to Geospatial Raster and Vector Data with R".

- **This fork:** https://github.com/jonjab/r-raster-vector-geospatial
- **Upstream repository:** https://github.com/datacarpentry/r-raster-vector-geospatial

The lesson teaches learners how to work with raster and vector geospatial data using R, specifically using the `terra` and `sf` packages. The lesson is part of the [Data Carpentry Geospatial workshop](https://www.datacarpentry.org/geospatial-workshop/).

The repository uses The Carpentries Workbench ([sandpaper](https://github.com/carpentries/sandpaper)) for building and rendering lesson content.

## Build System

This repository uses the Carpentries Workbench toolchain:

**Build and preview the lesson locally:**
```r
# In R console
sandpaper::serve()
# Site will be available at http://localhost:4321
```

**Build without serving:**
```r
sandpaper::build_lesson()
```

**Trigger package cache update:**
```r
sandpaper::package_cache_trigger(TRUE)
```

The lesson is automatically built and deployed via GitHub Actions on pushes to `main` branch.

- **Upstream published site:** https://datacarpentry.org/r-raster-vector-geospatial/
- **This fork:** GitHub Actions may be configured differently; check `.github/workflows/` for deployment settings

## Repository Structure

- `episodes/` - Lesson content as R Markdown files (.Rmd). Episodes are numbered 01-14 and follow the sequence defined in `config.yaml`
- `episodes/setup.R` - Downloads required datasets from figshare and Natural Earth
- `episodes/data/` - Local data storage (populated by setup.R)
- `learners/` - Setup instructions and reference materials for learners
- `instructors/` - Instructor notes with teaching tips and timing suggestions
- `config.yaml` - Lesson metadata and episode ordering
- `renv/` - R package management using renv
- `renv/profiles/lesson-requirements/renv.lock` - Locked package versions for the lesson

## Lesson Content Structure

The lesson is divided into 14 episodes covering:

1. **Episodes 1-5**: Raster data (structure, plotting, reprojection, calculations, multi-band)
2. **Episodes 6-10**: Vector data (shapefiles, attributes, plotting, CRS handling, CSV to shapefile)
3. **Episodes 11-14**: Integration and time series (raster-vector integration, time series raster data, visualization, NDVI extraction)

Each episode:
- Uses YAML front matter with `title`, `teaching`, `exercises`, and `source: Rmd`
- Includes R code chunks with `setup.R` sourced at the beginning
- Follows Carpentries formatting with `objectives`, `questions`, and `callout` blocks
- Loads standard packages: `terra`, `ggplot2`, `dplyr`, and `sf` (for vector episodes)

## Key R Packages

Core geospatial packages used throughout:
- `terra` - Raster data manipulation (replaces older `raster` package)
- `sf` - Vector data manipulation (replaces older `sp` package)
- `ggplot2` - Plotting with `geom_raster()` and `geom_sf()`
- `dplyr` - Data manipulation

## Data Setup

Run the setup script to download all required datasets:
```r
source("episodes/setup.R")
```

This downloads:
- NEON site layout files
- NEON airborne remote sensing data (raster)
- NEON meteorological time series
- Landsat NDVI time series
- Natural Earth graticules and land boundaries

Data is stored in `episodes/data/` and should not be committed to the repository.

## Development Workflow

**Main development branch:** `main`

**Working with the fork:**
- This is a fork of the upstream Data Carpentry repository
- To sync with upstream changes:
  ```bash
  # Add upstream remote (if not already added)
  git remote add upstream https://github.com/datacarpentry/r-raster-vector-geospatial.git

  # Fetch and merge upstream changes
  git fetch upstream
  git checkout main
  git merge upstream/main
  ```

**Episode editing:**
- Edit `.Rmd` files in `episodes/` directory
- Each episode sources `setup.R` at the beginning
- Code examples assume data and packages from all previous episodes are loaded
- Learners should save their code to a script throughout the lesson

**Testing changes locally:**
1. Make sure R packages are installed (managed via renv)
2. Run `sandpaper::serve()` to preview changes
3. Check that all code chunks execute successfully

**Important notes for contributors:**
- This is a fork - changes here won't automatically go to the upstream Data Carpentry repository
- To contribute to upstream, submit PRs to https://github.com/datacarpentry/r-raster-vector-geospatial
- Episode timing in the YAML frontmatter may need updating based on actual teaching experience
- Do not make manual commits to `gh-pages` branch - it's managed by GitHub Actions
- Lessons assume learners have completed the [Introduction to R for Geospatial Data](https://datacarpentry.org/r-intro-geospatial/) lesson
- Lessons are designed to work cross-platform (Windows, macOS, Linux)

## Known Issues

- `geom_sf()` has an intermittent bug on some platforms causing "polygon edge not found" errors. Re-running the plotting command usually resolves it.
- Pre-installation is critical - geospatial data and software are large and time-consuming to install during workshops

## Style and Conventions

- Keep new content within the 14 existing episodes unless adding new topics
- When adding new concepts, estimate teaching time and explain what would be removed to make room
- Use `ggplot2` for all plotting (not base R plots)
- Use `dplyr` pipe syntax where appropriate
- For raster data, use `terra` package functions (not deprecated `raster` package)
- For vector data, use `sf` package functions (not deprecated `sp` package)
- Explicitly explain each step of complex function calls, especially for long `ggplot` chains
