local plugins = {
  -- ファイル管理
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    lazy = false,
    config = function()
      require("extensions.oil")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- コア機能
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("extensions.nvim-treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    config = function()
      require("extensions.nvim-treesitter-context")
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- UI系
  {
    "rmehri01/onenord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("extensions.onenord")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
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
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("extensions.noice")
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "echasnovski/mini.icons",
    version = false,
    lazy = true,
  },
  {
    "folke/which-key.nvim",
    lazy = false,
    priority = 2000,
    config = function()
      require("extensions.which-key")
    end,
  },

  -- 検索系
  {
    "kevinhwang91/nvim-hlslens",
    lazy = false,
    config = function()
      require("scrollbar.handlers.search").setup(require("extensions.nvim-hlslens"))
    end,
  },

  -- Git統合
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("extensions.gitsigns")
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- ナビゲーション
  {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    config = function()
      require("extensions.nvim-navic")
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      require("extensions.nvim-scrollbar")
    end,
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
  },

  -- ファイル検索
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    lazy = false,
    config = function()
      require("extensions.telescope")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "tom-anders/telescope-vim-bookmarks.nvim",
      "MattesGroeger/vim-bookmarks",
    },
  },

  -- LSP関連
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("extensions.nvim-lspconfig")
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("extensions.mason")
    end,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      "nvimtools/none-ls.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("extensions.none-ls")
    end,
  },

  -- コード操作
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("extensions.comment")
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    config = function()
      require("extensions.trouble")
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "SmiteshP/nvim-navbuddy",
    lazy = false,
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

  -- スニペット
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    event = "InsertEnter",
    build = "make install_jsregexp",
    config = function()
      require("extensions.luasnip")
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  },

  -- 補完系
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
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
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "L3MON4D3/LuaSnip", -- スニペットエンジン
      "saadparwaiz1/cmp_luasnip", -- スニペット補完ソース
    },
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("extensions.copilot")
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
    dependencies = {
      "hrsh7th/nvim-cmp",
      "zbirenbaum/copilot.lua",
    },
  },

  -- 編集系
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "BufReadPost",
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
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("extensions.nvim-ts-autotag")
    end,
  },
}
local opts = {
  defaults = {
    lazy = true,
  },
  checker = {
    enabled = true,
    notify = false,
    frequency = 86400,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
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
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🔑",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
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
      { out, "WarningMsg" },
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
