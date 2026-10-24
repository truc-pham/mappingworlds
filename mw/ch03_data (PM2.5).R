# Exercise: PM2.5 map for Southeast Asia

# 1. Path for the cached file
pm_file <- here("data", "raw", "wb_pm25_2019.csv")

# 2. Download only if the file does not exist yet
if (!file.exists(pm_file)) {
  pm_dl <- WDI(
    country   = "all",
    indicator = c(pm25 = "EN.ATM.PM25.MC.M3"),
    start = 2019, end = 2019,
    extra = TRUE
  )
  write_csv(pm_dl, pm_file)
}

# 3. Read it back
pm <- read.csv(pm_file)

# 4. Clean: drop aggregates, keep 3 columns, drop missing values
pm_clean <- pm |>
  filter(region != "Aggregates") |>
  select(country, iso3c, pm25) |>
  filter(!is.na(pm25))

# 5. Join to the Southeast Asia map (sea already exists)
sea_pm <- sea |>
  left_join(pm_clean, by = c("adm0_a3" = "iso3c"))

# Map drawing
pacman::p_load(ggrepel)

# PM2.5 map with non-overlapping labels
ggplot(sea_pm) +
  geom_sf(aes(fill = pm25), colour = "white", linewidth = 0.2) +
  geom_text_repel(
    aes(label = name, geometry = geometry),
    stat = "sf_coordinates",
    size = 3,
    min.segment.length = 0,
    bg.color = "white", bg.r = 0.15
  ) +
  scale_fill_viridis_c(name = "PM2.5 (µg/m³)") +
  labs(title = "PM2.5 concentration in Southeast Asia, 2019",
       caption = "Data: World Bank WDI (EN.ATM.PM25.MC.M3); boundaries: Natural Earth",
       x = NULL, y = NULL) +
  theme_minimal()
