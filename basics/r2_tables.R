pacman::p_load(tidyverse)

# Create data table 
vn <- tibble(
  city   = c("Ho Chi Minh", "Ha Noi", "Da Nang", "Can Tho", "Hai Phong", "Hue"),
  region = c("South", "North", "Central", "South", "North", "Central"),
  pop_m  = c(9.5, 8.4, 1.2, 1.3, 2.1, 1.2),
  area   = c(2095, 3359, 1285, 1439, 1562, 4947),
  temp   = c(28, 24, 26, 27, 23, 25)
)

vn

# check data table 
nrow(vn)       # number of rows
names(vn)      # column names
glimpse(vn)    # columns and their types
vn$pop_m       # one column, as a vector
View(vn)       # open the table like a spreadsheet

# filter 
vn |> filter(region == "South")
vn |> filter(temp > 25)
vn |> filter(region == "North", pop_m > 5)
vn |> filter(city %in% c("Hue", "Da Nang"))

# 4. Select
vn |> select(city, temp)
vn |> select(-region)

# 5. Mutate
vn |> mutate(temp_f = temp * 9 / 5 + 32)
vn |> mutate(density = pop_m * 1e6 / area)

# 6. arrange
vn |> arrange(temp)
vn |> arrange(desc(temp))

# 7. piping 
vn |>
  filter(region != "North") |>
  mutate(density = pop_m * 1e6 / area) |>
  select(city, density) |>
  arrange(desc(density))

# Add columns to the table
rain <- tibble(
  city    = c("Ho Chi Minh", "Ha Noi", "Da Nang", "Hue"),
  rain_mm = c(1950, 1680, 2500, 2900)
)

vn2 <- vn |> left_join(rain, by = "city")

## Self-practice 
vn |> filter(region == "Central")
vn |> filter(pop_m > 2.0)
vn |> filter(region == "South", temp > 27)
vn |> select(city, pop_m)
vn |> arrange(desc(area))
vn1 <- vn |> mutate(density = pop_m * 1e6 / area)
vn1 |> arrange(desc(density))
mean(vn$pop_m)
vn |> 
  filter(temp >= 25) |>
  select(city, temp) |>
  arrange(desc(temp))
vn2|> filter(!is.na(rain_mm))
  