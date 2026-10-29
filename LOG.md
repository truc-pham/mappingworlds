## Session 1 — 2026-10-20/22
- Learned: geographic (degrees) vs projected (metres) CRS; st_transform()
- Error + fix:
- Idea for my own data:

## Session 2 — 2026-10-22/23
- Learned: vector (sf) vs raster (terra); sf = table + geometry column; st_as_sf() from coordinates;
  project() for rasters, st_transform() for vectors; smaller zscale = taller mountains
- Error + fix: project() failed with "empty srs" → unset PROJ_LIB in .Rprofile
- Idea: 3D land cover map of HCMC draped over a DEM

## Session 3 — 2026-10-24/25
- Learned: read_csv() for tables, st_read() for vectors, rast() for rasters;
  left_join() by ISO code; project() vs rast(); clamp() and crop() on a DEM;
  hillshade with terrain() + shade(); full rayshader pipeline + render_snapshot()
- Error + fix: read_csv() on a .tif → use rast(); "magick package required" → install magick;
  'object not found' in ggplot → layer had the wrong data
- Data check: DEM had -128 m over Dau Tieng reservoir → clamp(lower = 0)
- Idea: compare Ba Den at true scale vs 2x exaggeration

## R1: R grammar basics — 2026-10-27
- Learned: variables (<-), types (numeric/character/logical), vectors c(),
  functions with options, selecting by position [3] vs by condition [x > 25], paste()
- Mistakes + fixes: cities[max(temps)] gave NA (number = position) → use cities[temps == max(temps)];
  print(quote = ...) does not add text → use paste()
- Wrote all 13 exercises myself

## R2: tables and dplyr — 2026-10-28
- Learned: tibble(), $ to get a column, |> as "then",
  filter (rows), select (columns), mutate (new column), arrange/desc (sort), left_join (merge by key), %in% for many values
- Mistakes + fixes: arrange(desc(density)) "is a function" → column not saved yet (mutate result must be assigned);
  mean(vn, pop_m) → mean(vn$pop_m); filter on rain_mm before joining → join first; > vs >=
  
## R3: ggplot from scratch — 2026-10-28/29
- Learned: ggplot builds in layers with +; aes() maps columns (inside) vs fixed values (outside);
  fill for areas, colour for points/lines; geom_col, geom_point, geom_text_repel, geom_sf;
  scale_*_brewer / viridis; trans = "log10" + label_comma(); work backwards from the goal to plan steps
- Mistakes + fixes: fill = region on points → colour = region; fill inside and outside aes at once;
  ggplot(sea) alone = empty canvas (needs geom_sf); old 'sea' object had no pop_est → recreate;
  colour = with no value → "can't be empty"; pacman not found → open the .Rproj project