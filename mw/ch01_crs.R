pacman::p_load(sf, rnaturalearth, rnaturalearthdata)

vn <- ne_countries(country = "Vietnam", scale = "medium", returnclass = "sf")

vn

# Check the CRS
st_crs(vn)$epsg
st_bbox(vn)
plot(st_geometry(vn))

# Transform to meters
vn_utm <- st_transform(vn, crs = 32648)

st_crs(vn_utm)$epsg
st_bbox(vn_utm)
st_crs(vn_utm)$units

bb <- st_bbox(vn_utm)
(bb["xmax"] - bb["xmin"]) / 1000   # width of Vietnam in km
(bb["ymax"] - bb["ymin"]) / 1000   # height in km

# Compare 2 maps 
par(mfrow = c(1, 2))
plot(st_geometry(vn),     main = "EPSG:4326 (degrees)", axes = TRUE)
plot(st_geometry(vn_utm), main = "EPSG:32648 (metres)", axes = TRUE, border = "blue")
par(mfrow = c(1, 1))

usa <- ne_countries(country = "United States of America",
                    scale = "medium", returnclass = "sf")

usa_main <- st_crop(usa, xmin = -125, ymin = 24, xmax = -66, ymax = 50)

usa_albers <- st_transform(usa_main, crs = 5070)

par(mfrow = c(1, 2))
plot(st_geometry(usa_main),   main = "EPSG:4326 (degrees)", axes = TRUE)
plot(st_geometry(usa_albers), main = "EPSG:5070 (Albers, metres)", axes = TRUE, border = "blue")
par(mfrow = c(1, 1))

