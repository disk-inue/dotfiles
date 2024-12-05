local colors = require("onenord.colors").load()

require("onenord").setup({
  theme = "dark", 
  borders = true,
  fade_nc = false,
  styles = {
    comments = "NONE",
    strings = "NONE",
    keywords = "bold",
    functions = "bold",
    variables = "NONE",
    diagnostics = "underline",
  },
  disable = {
    background = true,
    float_background = false,
    cursorline = false,
    eob_lines = true,
  },
  inverse = {
    match_paren = false,
  },
  custom_highlights = {}, 
  custom_colors = {
    mypink = "#FFB2CC",
  },
})
