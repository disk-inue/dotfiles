local colors = require('onenord.colors').load()

local switch_color = {
  active = { fg = colors.active, bg = colors.mypink },
  inactive = { fg = colors.active, bg = colors.light_gray },
}

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

require('lualine').setup {

  options = {
    section_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = ''},
    component_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = ''},
    icons_enabled = true,
    theme = 'auto',
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },

  sections = {
    lualine_a = {
      'mode',
    },
    -- lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_b = {
      {
        'filename',
        file_status = true,
        newfile_status = true,
        path = 1,
        shorting_target = 40,
        symbols = { modified = '_󰷥', readonly = ' ', newfile = '󰄛', unnamed = '[No Name]' },
      },
    },
    -- lualine_c = {'filename'},
    lualine_c = {
      {
        'diagnostics',
        sources = {
          'nvim_diagnostic',
          'nvim_lsp'
        },
        sections = {
          'error',
          'warn',
          'info',
          'hint'
        },
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' '
        },
        update_in_insert = false,
        always_visible = false,
      },
      { 'navic' },
    },
    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_x = {
      {
        require('lazy.status').updates,
        cond = require('lazy.status').has_updates,
        color = {
          fg = '#ff9e64'
        },
      },
    },
    -- lualine_y = {'progress'},
    lualine_y = {
      {
        'filetype',
        colored = true,
        icon_only = false,
        color = {
          fg = colors.fg
        }
      },
    },
    -- lualine_z = {'location'},
    lualine_z = {
      {
        'fileformat',
        icons_enabled = true,
        symbols = {
          unix = '', -- e712
          dos = '', -- e70f
          mac = '', -- e711
        },
        separator = {
          left = '',
          right = ''
        }
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        show_filename_only = true,       -- Shows shortened relative path when set to false.
        hide_filename_extension = false, -- Hide filename extension when set to true.
        show_modified_status = true,     -- Shows indicator when the buffer is modified.

        mode = 0,
        -- 0: Shows buffer name
        -- 1: Shows buffer index
        -- 2: Shows buffer name + buffer index
        -- 3: Shows buffer number
        -- 4: Shows buffer name + buffer number

        max_length = vim.o.columns * 2 / 3,
        -- Maximum width of buffers component,
        -- it can also be a function that returns
        -- the value of `max_length` dynamically.

        filetype_names = {
          TelescopePrompt = 'Telescope',
          dashboard = 'Dashboard',
          packer = 'Packer',
          fzf = 'FZF',
          alpha = 'Alpha'
        }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

        -- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
        use_mode_colors = false,

        buffers_color = switch_color,
        -- buffers_color = {
        -- Same values as the general color option can be used here.
        -- active = 'lualine_{section}_normal',     -- Color for active buffer.
        -- inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
        -- },

        symbols = {
          modified = '_󰷥',
          alternate_file = ' ',
          directory = ' '
        },
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {
      {
        'diff',
        colored = true,
        -- diff_color = {
          -- added    = 'LuaLineDiffAdd',    -- Changes the diff's added color
          -- modified = 'LuaLineDiffChange', -- Changes the diff's modified color
          -- removed  = 'LuaLineDiffDelete', -- Changes the diff's removed color you
        -- },
        symbols = {
          added = ' ',
          modeiffied = ' ',
          removed = ' '
        },
        source = diff_source
      },
    },
    lualine_y = {
      {
        'b:gitsigns_head',
        icon = {
          '',
          color = {
            fg = colors.orange
          }
        },
        color = {
          fg = colors.fg
        }
      },
    },
    lualine_z = {
      { 'tabs', tabs_color = switch_color },
    },
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

vim.api.nvim_set_option('showmode', false)
