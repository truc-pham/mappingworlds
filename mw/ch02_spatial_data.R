pacman::p_load(sf, rnaturalearth, rnaturalearthdata, tidyverse, here)

world <- ne_countries(scale = "medium", returnclass = "sf")

# sf object
class(world)
glimpse(world)
st_geometry_type(world)[1:3]

# Separate the two parts
world_table <- st_drop_geometry(world)
class(world_table)

world_shapes <- st_geometry(world)
world_shapes

# Testing
cities <- tibble(
  name = c("Ha Noi", "Da Nang", "Da Lat", "TP.HCM"),
  lon  = c(105.85, 108.22, 108.44, 106.70),
  lat  = c(21.03, 16.05, 11.94, 10.78)
)

cities_sf <- st_as_sf(cities, coords = c("lon", "lat"), crs = 4326)
cities_sf

# Maps with ggplot
vn <- filter(world, admin == "Vietnam")

ggplot() +
  geom_sf(data = vn, fill = "grey90") +
  geom_sf_text(aes(label = country), size = 3) +
  geom_sf(data = cities_sf, colour = "red", size = 3) +
  geom_sf_text(data = cities_sf, aes(label = name), nudge_x = 1.2, size = 3) +
  coord_sf(xlim = c(102, 112)) +
  theme_minimal()

st_write(cities_sf, here("data", "derived", "vn_cities.gpkg"), delete_dsn = TRUE)

check <- st_read(here("data", "derived", "vn_cities.gpkg"))
st_crs(check)$epsg
