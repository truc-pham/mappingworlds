# Session 3B: first full 3D map - Ba Den mountain
pacman::p_load(terra, sf, elevatr, here, rayshader, scico, colorspace, magick)

# 1. Area of interest (in degrees)
aoi <- st_as_sfc(st_bbox(
  c(xmin = 106.05, ymin = 11.25, xmax = 106.30, ymax = 11.50),
  crs = 4326
))

# 2. UTM zone from the mountain's longitude (106.17)
zone    <- floor((106.17 + 180) / 6) + 1
utm_crs <- paste0("EPSG:", 32600 + zone)

# 3. Download once, cache in data/raw
dem_file <- here("data", "raw", "baden_dem_4326.tif")

if (!file.exists(dem_file)) {
  dem_dl <- get_elev_raster(locations = st_sf(geometry = aoi), z = 11, clip = "bbox")
  writeRaster(rast(dem_dl), dem_file, overwrite = TRUE)
}

# 4. Read the file and project it to metres
dem     <- rast(dem_file)
dem_utm <- project(dem, utm_crs)

res(dem_utm)
dem_utm

# Step 5
pal <- scico(100, palette = "nuuk")
plot(dem_utm, col = pal, main = "Ba Den mountain - elevation (m)")

# Step 6: remove impossible negative elevations
dem_utm <- clamp(dem_utm, lower = 0)
dem_utm

# Step 7: crop to a smaller box around the mountain (metres)
dem_crop <- crop(dem_utm, ext(622000, 634000, 1252000, 1264000))
plot(dem_crop, col = pal, main = "Ba Den mountain - elevation (m)")

# Step 8: hillshade to show relief
slope  <- terrain(dem_crop, v = "slope",  unit = "radians")
aspect <- terrain(dem_crop, v = "aspect", unit = "radians")
hill   <- shade(slope, aspect, angle = 40, direction = 315)

plot(hill, col = grey(0:100 / 100), legend = FALSE,
     main = "Ba Den mountain - elevation (m)")
plot(dem_crop, col = pal, alpha = 0.5, add = TRUE)

# Step 9: raster to matrix
mat  <- raster_to_matrix(dem_crop)
cell <- res(dem_crop)[1]
cell

# Step 10: colour, shadows, 3D scene
tex <- scico(256, palette = "nuuk")

mat |>
  height_shade(texture = tex) |>
  add_shadow(ray_shade(mat, zscale = cell, sunaltitude = 40, sunangle = 315), 0.5) |>
  add_shadow(lamb_shade(mat, zscale = cell, sunaltitude = 40, sunangle = 315), 0.5) |>
  plot_3d(mat, zscale = cell,
          theta = 225, phi = 35, zoom = 0.75,
          windowsize = c(1000, 800), background = "white")

# Step 11: save a snapshot with a title
render_snapshot(
  here("out", "ba_den_3d.png"),
  title_text = "Ba Den mountain, Tay Ninh (true scale)",
  title_size = 24,
  title_bar_color = "#1e3d59",
  title_color = "white",
  vignette = 0.2
)

rgl::close3d()