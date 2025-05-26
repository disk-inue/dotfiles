local fb_actions = require("telescope").extensions.file_browser.actions

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<esc>"] = require("telescope.actions").close,
        ["<C-[>"] = require("telescope.actions").close,
        -- より便利なキーマッピングを追加
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
      n = {
        ["<C-h>"] = "which_key",
        ["q"] = require("telescope.actions").close,
      },
    },
    winblend = 20,
    path_display = { "truncate" },
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    -- 隠しファイル・フォルダを検索対象に含める
    hidden = true,
    -- 除外パターンを調整（必要最小限に絞る）
    file_ignore_patterns = {
      "%.git/",
      "node_modules/",
      "%.DS_Store",
      "%.pyc",
      "__pycache__/",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    file_browser = {
      -- ファイルブラウザの設定
      theme = "dropdown",
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<C-w>"] = function()
            vim.cmd("normal vbd")
          end,
        },
        ["n"] = {
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd("startinsert")
          end,
        },
      },
    },
    project = {
      base_dirs = {
        { path = "~/work/workspace", max_depth = 2 },
        { path = "~/.config/nvim", max_depth = 2 },
      },
      hidden_files = true, -- 隠しファイルも表示
      theme = "dropdown",
    },
    vim_bookmarks = {
      -- vim-bookmarksの設定
      theme = "dropdown",
      width = 0.6,
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown", -- ドロップダウンUIを使用
      previewer = false, -- プレビュー無効化
      hidden = true, -- 隠しファイルも表示
    },
    live_grep = {
      theme = "dropdown",
      -- grepでも隠しファイルを対象にする
      additional_args = function()
        return { "--hidden" }
      end,
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      initial_mode = "normal",
    },
  },
})

-- 各拡張を読み込み
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("project")
require("telescope").load_extension("vim_bookmarks")
