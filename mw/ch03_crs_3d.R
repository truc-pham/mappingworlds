pacman::p_load(terra, sf, elevatr, here)

aoi <- st_as_sfc(st_bbox(
  c(xmin = 108.30, ymin = 11.85, xmax = 108.60, ymax = 12.10),
  crs = 4326
))

dem_file <- here("data", "raw", "dalat_dem_4326.tif")

if (!file.exists(dem_file)) {
  dem_dl <- get_elev_raster(locations = st_sf(geometry = aoi), z = 10, clip = "bbox")
  writeRaster(rast(dem_dl), dem_file, overwrite = TRUE)
}

dem <- rast(dem_file)

# look at the downloaded raster
dem
plot(dem)
res(dem)
crs(dem, describe = TRUE)

# Choose right UTM zone
zone <- floor((108.44 + 180) / 6) + 1
zone

utm_crs <- paste0("EPSG:", 32600 + zone)
utm_crs

# Project DEM into meters
dem_utm <- project(dem, utm_crs)

res(dem_utm)

writeRaster(dem_utm, here("data", "derived", "dalat_dem_utm.tif"), overwrite = TRUE)

par(mfrow = c(1, 2))
plot(dem,     main = "Degrees (EPSG:4326)")
plot(dem_utm, main = "Metres (UTM)")
par(mfrow = c(1, 1))

cities <- st_read(here("data", "derived", "vn_cities.gpkg"))
dalat  <- cities[cities$name == "Da Lat", ]

plot(dem_utm, main = "Sai: điểm vẫn ở độ")
plot(st_geometry(dalat), add = TRUE, col = "red", pch = 19, cex = 2)

# Step 5: CRS mismatch - point in degrees, DEM in metres
cities <- st_read(here("data", "derived", "vn_cities.gpkg"))
dalat  <- cities[cities$name == "Da Lat", ]

plot(dem_utm, main = "Wrong: point still in degrees")
plot(st_geometry(dalat), add = TRUE, col = "red", pch = 19, cex = 2)

# Step 6: transform the point to the DEM's CRS
dalat_utm <- st_transform(dalat, crs = crs(dem_utm))

st_coordinates(dalat)
st_coordinates(dalat_utm)

plot(dem_utm, main = "Correct: point transformed to metres")
plot(st_geometry(dalat_utm), add = TRUE, col = "red", pch = 19, cex = 2)

# Step 7: first 3D map
pacman::p_load(rayshader)

mat  <- raster_to_matrix(dem_utm)
cell <- res(dem_utm)[1]

mat |>
  sphere_shade(texture = "imhof1") |>
  add_shadow(ray_shade(mat, zscale = cell / 2), 0.5) |>
  plot_3d(mat, zscale = cell / 4,
          theta = 135, phi = 40, zoom = 0.7,
          windowsize = c(900, 700))

render_snapshot(here("out", "dalat_3d_preview.png"))
rgl::close3d()
