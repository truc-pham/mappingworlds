# Folders for raw and processed data
for (p in c("data/raw", "data/derived")) {
  dir.create(here::here(p), recursive = TRUE, showWarnings = FALSE)
}

sample(1:100, 5)
sample(1:100, 5)

set.seed(42)
sample(1:100, 5)
set.seed(42)
sample(1:100, 5)

pacman::p_load(rayshader, here)

set.seed(42)
render_mode <- "preview"   # change to "final" for the big version

if (render_mode == "preview") {
  px <- 800;  dpi <- 100
} else {
  px <- 2400; dpi <- 300
}

shade <- sphere_shade(volcano, texture = "imhof1")

png(here("out", paste0("volcano_", render_mode, ".png")),
    width = px, height = px, res = dpi)
plot_map(shade)
dev.off()