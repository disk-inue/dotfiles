local plugins = {
  -- ファイル管理
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
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
  
  -- UI系 (起動時に即ロード必要)
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
  
  -- 検索系
  {
    "kevinhwang91/nvim-hlslens",
    event = "BufReadPost",
    keys = {
      "<leader>L",
    },
    config = function()
      require("scrollbar.handlers.search").setup(require("extensions.nvim-hlslens"))
    end,
  },
  
  -- Git統合
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    config = function()
      require("extensions.gitsigns")
    end,
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
    cmd = "Telescope",
    keys = {
      "<leader>ff",
      "<leader>fg",
      "<leader>fb",
      "<leader>fh",
    },
    config = function()
      require("extensions.telescope")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
    event = "BufReadPost",
    config = function()
      require("extensions.comment")
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      "<leader>xx",
      "<leader>xX",
      "<leader>cs",
      "<leader>cl",
      "<leader>xL",
      "<leader>xQ",
    },
    config = function()
      require("extensions.trouble")
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "SmiteshP/nvim-navbuddy",
    cmd = "Navbuddy",
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
