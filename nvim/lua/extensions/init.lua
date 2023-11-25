local plugins = {
  { 'nvim-treesitter/nvim-treesitter',
    config = function() require 'extensions.nvim-treesitter' end,
  },
  { 'rmehri01/onenord.nvim',
    config = function() require 'extensions.onenord' end,
  },
  { 'nvim-lualine/lualine.nvim',
    config = function() require 'extensions.lualine' end,
    dependencies = { 
      'nvim-tree/nvim-web-devicons',
      'rmehri01/onenord.nvim',
      'lewis6991/gitsigns.nvim',
    }
  },
  { 'kevinhwang91/nvim-hlslens',
    config = function() require 'extensions.nvim-hlslens' end,
  },
  { 'lewis6991/gitsigns.nvim',
    config = function() require 'extensions.gitsigns' end,
  },
  { 'petertriho/nvim-scrollbar',
    config = function() require 'extensions.nvim-scrollbar' end,
    dependencies = {
      'kevinhwang91/nvim-hlslens','lewis6991/gitsigns.nvim'
    }
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    config = function() require 'extensions.telescope' end,
    dependencies = { 
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      {
        'prochri/telescope-all-recent.nvim',
        config = function() require 'extensions.telescope-all-recent' end,
        dependencies = {
          'nvim-telescope/telescope.nvim',
          'kkharji/sqlite.lua',
        },
      },
    },
  },
}

local opts = {
  preformance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "gzip",
        "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    }
  }
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)
