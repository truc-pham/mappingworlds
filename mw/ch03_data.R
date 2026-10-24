# Session 3A: find, load, clean, join
pacman::p_load(sf, rnaturalearth, rnaturalearthdata, tidyverse, here, WDI)

forest_file <- here("data", "raw", "wb_forest_2020.csv")

if (!file.exists(forest_file)) {
  forest_dl <- WDI(
    country   = "all",
    indicator = c(forest_pct = "AG.LND.FRST.ZS"),
    start = 2020, end = 2020,
    extra = TRUE
  )
  write_csv(forest_dl, forest_file)
}

# Read CSV
forest <- read_csv(forest_file)

glimpse(forest)

# Clean data
forest_clean <- forest |>
  filter(region != "Aggregates") |>
  select(iso3c, country, forest_pct) |>
  filter(!is.na(forest_pct))

# Southeast Asia bounday
sea <- ne_countries(scale = "medium", returnclass = "sf") |>
  filter(subregion == "South-Eastern Asia") |>
  select(adm0_a3, name)

sea

# Connect data to maps
sea_forest <- sea |>
  left_join(forest_clean, by = c("adm0_a3" = "iso3c"))

sea_forest |> st_drop_geometry() |> arrange(desc(forest_pct))

# Map drawing
ggplot(sea_forest) +
  geom_sf(aes(fill = forest_pct), colour = "white", linewidth = 0.2) +
  scale_fill_viridis_c(name = "Forest (%)") +
  labs(title = "Forest area in Southeast Asia, 2020",
       caption = "Data: World Bank WDI (AG.LND.FRST.ZS); boundaries: Natural Earth") +
  theme_minimal()

# Save
st_write(sea_forest, here("data", "derived", "sea_forest_2020.gpkg"), delete_dsn = TRUE)
