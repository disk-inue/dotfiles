require('nvim-tree').setup {
  sort = {
    -- sorter = 'extension',
    sorter = 'case_sensitive',
  },

  view = {
    width = '20%',
    side = 'right',
    signcolumn = 'no',
  },

  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = 'name',
    icons = {
      glyphs = {
        git = {
          unstaged = '!', renamed = '»', untracked = '?', deleted = '✘',
          staged = '✓', unmerged = '', ignored = '◌',
        },
      },
    },
  },

  filters = {
    git_ignored = false,
  },

  actions = {
    expand_all = {
      max_folder_discovery = 100,
      exclude = { '.git' },
    },
  },

  on_attach = require('extensions.nvim-tree-actions').on_attach,
}

vim.api.nvim_create_user_command('Ex', function() vim.cmd.NvimTreeToggle() end, {})
vim.keymap.set('n', '<leader>ex', vim.cmd.NvimTreeToggle)
