pacman::p_load(sf, rnaturalearth, rnaturalearthdata, tidyverse, here, scales, ggspatial)

# Step 0: Asia data download 
world <- ne_countries(
  scale = "medium",
  returnclass = "sf"
)

asia <- world |>
  filter(continent == "Asia")

# Step 1: area and population density
asia <- asia |>
  mutate(
    area_km2 = as.numeric(st_area(geometry)) / 1e6,
    density  = pop_est / area_km2
  )

asia |> st_drop_geometry() |> arrange(desc(density)) |> head()

# Step 2 Plotting maps
ggplot(data = asia) +
  geom_sf(aes(fill = density), color = "white", linewidth = 0.2) +
  scale_fill_viridis_c(
    name = "Population density\n(people/km²)",
    trans = "log10", 
    labels = label_comma()
  ) +
  labs(
    title = "Population Density in Asia",
    caption = "Data: Natural Earth"
  ) +
  theme_minimal()
