# Folders for raw and processed data
for (p in c("data/raw", "data/derived")) {
  dir.create(here::here(p), recursive = TRUE, showWarnings = FALSE)
}

