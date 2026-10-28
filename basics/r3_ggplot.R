pacman::p_load(tidyverse, sf, rnaturalearth, rnaturalearthdata, ggrepel)

vn <- tibble(
  city   = c("Ho Chi Minh", "Ha Noi", "Da Nang", "Can Tho", "Hai Phong", "Hue"),
  region = c("South", "North", "Central", "South", "North", "Central"),
  pop_m  = c(9.5, 8.4, 1.2, 1.3, 2.1, 1.2),
  area   = c(2095, 3359, 1285, 1439, 1562, 4947),
  temp   = c(28, 24, 26, 27, 23, 25)
)

vn

ggplot(vn, aes(x = city, y = pop_m, fill = region)) +
  geom_col() + 
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Population of six Vietnamese cities",
       x = NULL, y = "Population (million)", fill = "Region",
       caption = "Approximate values, for practice") +
  theme_minimal()

ggsave("out/vn_population.png", width = 8, height = 6, dpi = 300)

# Self-practice 
ggplot(vn, aes(x = city, y = temp, fill = region)) +
  geom_col() +
  labs(title = "Temperature (°C)", 
        x = "Cities", y = "Temperature (°C)", fill = "region") +
  theme_minimal()

ggplot(vn, aes(x = area, y = pop_m, colour = region)) +
  geom_point(size = 4) +
  geom_text_repel(aes(label = city), size = 3.5, show.legend = FALSE) +
  scale_y_continuous(expand = expansion(mult = 0.15)) +
  labs(title = "Area and population of six cities",
       x = "Area (km²)", y = "Population (Million)", colour = "Region") +
  theme_minimal()
  

# Task 
sea <- ne_countries(scale = "medium", returnclass = "sf") |>
  filter(subregion == "South-Eastern Asia")

names(sea)

sea <- sea |>
  mutate(
    area_km2    = as.numeric(st_area(geometry)) / 1e6,
    pop_density = pop_est / area_km2
  )
ggplot(sea) +
  geom_sf(fill = "tomato", colour = )


