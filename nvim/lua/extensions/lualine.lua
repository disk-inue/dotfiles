-- カラースキーマからの色を取得
local colors = require("onenord.colors").load()

-- Git差分の情報を取得する
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

-- バッファタブの色設定
local switch_color = {
  active = { fg = colors.bg, bg = colors.green },
  inactive = { fg = colors.fg, bg = colors.light_gray },
}

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "dashboard", "alpha" },
      winbar = { "dashboard", "alpha" },
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },

  sections = {
    lualine_a = {
      {
        "mode",
      },
    },
    lualine_b = {
      {
        "filetype",
        colored = true,
        icon_only = true,
        color = { fg = colors.fg },
        padding = { left = 1, right = 0 },
      },
      {
        "filename",
        file_status = true,
        newfile_status = true,
        path = 1, -- 相対パス
        shorting_target = 40,
        symbols = { modified = "_󰷥", readonly = " ", newfile = "󰄛", unnamed = "[No Name]" },
        color = { fg = colors.fg },
      },
    },
    lualine_c = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic", "nvim_lsp" },
        sections = { "error", "warn", "info", "hint" },
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = " ",
        },
        colored = true,
        always_visible = false,
        update_in_insert = false,
        padding = { left = 1, right = 1 },
      },
      {
        function()
          local navic = require("nvim-navic")
          if navic.is_available() then
            return navic.get_location()
          else
            return ""
          end
        end,
        cond = function()
          local navic = require("nvim-navic")
          return navic.is_available() and navic.get_location() ~= ""
        end,
        color = { fg = colors.blue },
      },
    },
    lualine_x = {
      {
        "location",
        padding = { left = 1, right = 0 },
      },
    },
    lualine_y = {
      {
        "progress",
        padding = { left = 0, right = 1 },
      },
    },
    lualine_z = {
      {
        "fileformat",
        icons_enabled = true,
        symbols = {
          unix = "", -- e712
          dos = "", -- e70f
          mac = "", -- e711
        },
        color = { bg = colors.green, fg = colors.bg },
        padding = { left = 1, right = 1 },
      },
    },
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },

  tabline = {
    lualine_a = {
      {
        "buffers",
        show_filename_only = true,
        hide_filename_extension = false,
        show_modified_status = true,
        mode = 0,
        max_length = vim.o.columns * 2 / 3,
        filetype_names = {
          TelescopePrompt = "Telescope",
          dashboard = "Dashboard",
          lazy = "Lazy",
          fzf = "FZF",
          alpha = "Alpha",
          oil = "Oil",
        },
        use_mode_colors = false,
        buffers_color = switch_color,
        symbols = {
          modified = "_󰷥",
          alternate_file = " ",
          directory = " ",
        },
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {
      {
        "diff",
        colored = true,
        symbols = {
          added = " ",
          modified = " ",
          removed = " ",
        },
        source = diff_source,
      },
    },
    lualine_y = {
      {
        "branch",
        icon = {
          "",
          color = {
            fg = colors.orange,
          },
        },
        color = {
          fg = colors.fg,
        },
      },
    },
    lualine_z = {
      { "tabs", tabs_color = switch_color },
    },
  },

  winbar = {},
  inactive_winbar = {},
  extensions = { "trouble", "lazy", "mason", "oil" },
})
