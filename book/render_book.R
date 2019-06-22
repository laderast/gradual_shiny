library(here)
library(bookdown)

setwd(here("book"))
bookdown::render_book(".", output_dir = here::here("docs/"))