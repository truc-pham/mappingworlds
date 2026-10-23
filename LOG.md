## Session 1 — 2026-10-20/22
- Learned: geographic (degrees) vs projected (metres) CRS; st_transform()
- Error + fix:
- Idea for my own data:

## Session 2 — 2026-10-22/23
- Learned: vector (sf) vs raster (terra); sf = table + geometry column; st_as_sf() from coordinates;
  project() for rasters, st_transform() for vectors; smaller zscale = taller mountains
- Error + fix: project() failed with "empty srs" → unset PROJ_LIB in .Rprofile
- Idea: 3D land cover map of HCMC draped over a DEM