# library(here)
# library(prettycheck) # github.com/danielvartan/prettycheck
# library(yaml)

get_brand_color <- function(color) {
  brands_list <- yaml::read_yaml(here::here("_brand.yml"))

  palette_names <- brands_list$color$palette |> names()
  theme_names <- brands_list$color |> names()

  choices <- c(palette_names, theme_names)

  prettycheck:::assert_choice(color, choices)

  if (color %in% theme_names) {
    for (i in theme_names) {
      if (color == i) {
        color <- brands_list$color[[i]]
      }
    }
  }

  brands_list$color$palette[[color]]
}

# library(grDevices)
# library(prettycheck) # github.com/danielvartan/prettycheck

# # Helper
#
# get_brand_color_tint(c(1, seq(100, 1000, 100))) |> vector_to_c()
#
# c(1, seq(100, 1000, 100))
# #> [1]    1  100  200  300  400  500  600  700  800  900 1000
#
# c("#000000", "#2E1700", "#5D2F00", "#8C4700", "#BA5F00", "#E97600",
#   "#EE9233", "#F2AD66", "#F6C899", "#FAE3CC", "#FFFFFF")

get_brand_color_tint <- function(
    position = 500,
    color = "primary",
    n = 1000
  ) {
  prettycheck:::assert_integerish(position, lower = 0, upper = 1000)
  prettycheck:::assert_integer_number(n, lower = 1)

  color <- get_brand_color(color)

  color_fun <- grDevices::colorRampPalette(c("black", color, "white"))
  color_values <- color_fun(n)

  color_values[position]
}

# library(here)
# library(prettycheck) # github.com/danielvartan/prettycheck
# library(yaml)

get_brand_font <- function(type) {
  brands_list <- yaml::read_yaml(here::here("_brand.yml"))

  choices <- c(
    "base", "headings", "monospace", "monospace-inline", "monospace-block"
  )

  choices <- choices[choices %in% names(brands_list$typography)]

  prettycheck:::assert_choice(type, choices)

  if (is.null(names(brands_list$typography[[type]]))) {
    brands_list$typography[[type]]
  } else {
    brands_list$typography[[type]]$family
  }
}

library(magrittr)
# library(prettycheck) # github.com/danielvartan/prettycheck

format_to_md_latex <- function(
    x,
    after = NULL,
    round = 3,
    decimal_mark = ".",
    big_mark = ",",
    key = "$"
) {
  prettycheck:::assert_numeric(x)
  prettycheck:::assert_string(after, null.ok = TRUE)
  prettycheck:::assert_string(decimal_mark)
  prettycheck:::assert_string(big_mark)
  prettycheck:::assert_number(round, lower = 0)
  prettycheck:::assert_string(key)

  if (is.null(after)) after <- ""

  x |>
    round(round) |>
    format(
      decimal.mark = decimal_mark,
      big.mark = big_mark,
      scientific = FALSE
    ) %>% # Don't change the pipe!
    paste0(key, ., after, key)
}
