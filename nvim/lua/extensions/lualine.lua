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
    component_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      {
        'filename',
        newfile_status = true,
        path = 1,
        shorting_target = 24,
        symbols = { modified = '_󰷥', readonly = ' ', newfile = '󰄛' },
      },
    },
    lualine_c = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic', 'nvim_lsp' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      },
      { 'navic' },
    },
    lualine_x = {
      {
        require('lazy.status').updates,
        cond = require('lazy.status').has_updates,
        color = { fg = '#ff9364' },
      },
    },
    lualine_y = {
      { 'filetype', color = { fg = colors.fg } },
    },
    lualine_z = {
      { 'fileformat', icons_enabled = true, separator = { left = '', right = '' } },
    },
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        buffers_color = switch_color,
        symbols = { modified = '_󰷥', alternate_file = ' ', directory = ' ' },
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {
      { 'diff', symbols = { added = ' ', modeiffied = ' ', removed = ' ' }, source = diff_source },
    },
    lualine_y = {
      { 'b:gitsigns_head', icon = { '', color = { fg = colors.orange } }, color = { fg = colors.fg } },
    },
    lualine_z = {
      { 'tabs', tabs_color = switch_color },
    },
  },
}

vim.api.nvim_set_option('showmode', false)

