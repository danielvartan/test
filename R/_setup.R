## Based on <https://github.com/hadley/r4ds/blob/main/_common.R>.

# Load libraries -----

library(downlit)
library(ggplot2)
# library(here)
# library(knitr)
library(magrittr)
library(rlang)
# library(rutils) # github.com/danielvartan/rutils
# library(thematic)
library(xml2)
# library(yaml)

# Set general options -----

options(
  dplyr.print_min = 6,
  dplyr.print_max = 6,
  pillar.max_footer_lines = 2,
  pillar.min_chars = 15,
  scipen = 10,
  digits = 5,
  stringr.view_n = 6,
  pillar.bold = TRUE,
  width = 77 # 80 - 3 for #> comment
)

# Set variables -----

set.seed(2024)

# Load functions -----

source(here::here("R", "utils.R"))

# Set knitr -----

knitr::clean_cache()

knitr::opts_chunk$set(
  root.dir = here::here()
)

# Set `ggplot2` -----

ggplot2::theme_set(
  ggplot2::theme_bw()
)

thematic::thematic_set_theme(
  thematic::thematic_theme(
    bg = get_brand_color("white") |> paste0("00"),
    fg = get_brand_color("black"),
    accent = get_brand_color("secondary"),
    font = thematic::font_spec(
      families = get_brand_font("base"),
      install = TRUE
    )
  ) +
    ggplot2::theme(
      panel.background = ggplot2::element_rect(fill = "transparent"),
      plot.background = ggplot2::element_rect(fill = "transparent", color = NA),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      legend.background = ggplot2::element_rect(fill = "transparent"),
      legend.box.background = ggplot2::element_rect(fill = "transparent"),
      legend.frame = ggplot2::element_blank()
    )
)

# Run `rbbt` -----

# (2024-08-25)
# This function should work with any version of BetterBibTeX (BBT) for Zotero.
# Verify if @wmoldham PR was merged in the `rbbt` package (see issue #47
# <https://github.com/paleolimbot/rbbt/issues/47>). If not, install `rbbt`
# from @wmoldham fork `remotes::install_github("wmoldham/rbbt", force = TRUE)`.

rutils:::bbt_write_quarto_bib(
  bib_file = here::here("references.bib"),
  dir = c("."),
  pattern = "\\.qmd$",
  wd = here::here()
)
