local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.nvim-treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.nvim-treesitter-context")
    end,
  },
  {
    "rmehri01/onenord.nvim",
    event = { "VimEnter" },
    priority = 1000,
    config = function()
      require("extensions.onenord")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = { "VimEnter" },
    config = function()
      require("extensions.lualine")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "rmehri01/onenord.nvim",
      "lewis6991/gitsigns.nvim",
      "SmiteshP/nvim-navic",
    },
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = { "FilterWritePre" },
    config = function()
      require("scrollbar.handlers.search").setup(require("extensions.nvim-hlslens"))
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre" },
    config = function()
      require("extensions.gitsigns")
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.nvim-scrollbar")
    end,
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      "<leader>ff",
      "<leader>fg",
      "<leader>fb",
      "<leader>fh",
    },
    tag = "0.1.4",
    config = function()
      require("extensions.telescope")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "prochri/telescope-all-recent.nvim",
    keys = {
      "<leader>ff",
      "<leader>fg",
      "<leader>fb",
      "<leader>fh",
    },
    config = function()
      require("extensions.telescope-all-recent")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
    },
  },
  {
    "stevearc/oil.nvim",
    keys = {
      "<leader>ex",
    },
    config = function()
      require("extensions.oil")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.nvim-lspconfig")
    end,
  },
  {
    "williamboman/mason.nvim",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.mason")
    end,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.mason-null-ls")
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
  },
  {
    "SmiteshP/nvim-navic",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.nvim-navic")
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },
  {
    "SmiteshP/nvim-navbuddy",
    keys = {
      "<leader>nb",
    },
    config = function()
      require("extensions.nvim-navbuddy")
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.comment")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "VimEnter" },
    config = function()
      require("extensions.nvim-cmp")
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    event = { "InsertEnter" },
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      require("extensions.luasnip")
    end,
    dependencies = {
      "hrsh7th/nvim-cmp",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    event = { "InsertEnter" },
    config = function()
      require("copilot_cmp").setup()
    end,
    dependencies = {
      "hrsh7th/nvim-cmp",
      "zbirenbaum/copilot.lua",
    },
  },
  {
    "zbirenbaum/copilot.lua",
    event = { "InsertEnter" },
    config = function()
      require("extensions.copilot")
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.fidget")
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },
  {
    "folke/trouble.nvim",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.trouble")
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "rcarriga/nvim-notify",
    event = { "VimEnter" },
    config = function()
      require("extensions.nvim-notify")
    end,
  },
  {
    "mrded/nvim-lsp-notify",
    event = { "VimEnter" },
    -- event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.nvim-lsp-notify")
    end,
    dependencies = { "rcarriga/nvim-notify" },
  },
  {
    "folke/noice.nvim",
    event = { "VimEnter" },
    config = function()
      require("extensions.noice")
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.none-ls")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      require("extensions.lspsaga")
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("extensions.nvim-surround")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("extensions.nvim-autopairs")
    end,
  },
}

local opts = {
  defaults = {
    lazy = true,
  },
  checker = {
    enabled = true,
  },
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
    },
  },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = plugins,
  opts,
})
