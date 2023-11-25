local actions = require 'nvim-navbuddy.actions'

require('nvim-navbuddy').setup {
  window = {
    size = { height = '40%', width = '100%' },
    position = { row = '96%', col = '50%' },
  },
  mappings = {
    ['t'] = actions.telescope {
      layout_config = {
        height = 0.40,
        width = 0.90,
        prompt_position = 'top',
        preview_width = 0.70,
      },
      layout_strategy = 'horizontal',
    },
  },
  lsp = {
    auto_attach = true,
  }
}
vim.keymap.set('n', '<leader>nb', vim.cmd.Navbuddy)
