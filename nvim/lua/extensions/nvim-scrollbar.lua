local colors = require("onenord.colors").load()

require("scrollbar").setup({
  handle = {
    color = colors.bg_highlight,
  },
  marks = {
    Search = { color = colors.orange },
    Error = { color = colors.error },
    Warn = { color = colors.warn },
    Info = { color = colors.info },
    Hint = { color = colors.hint },
    Misc = { color = colors.purple },
  },
})
-- require('scrollbar.handlers.search').setup()
require("scrollbar.handlers.gitsigns").setup()
