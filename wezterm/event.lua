local wezterm = require 'wezterm';

-- toggle-font-size keybind event
-- wezterm.on('toggle-font-size', function(window, pane)
--   local overrides = window:get_config_overrides() or {}
--   overrides.font_size = not overrides.font_size and 10.0 or nil
--
--   window:set_config_overrides(overrides)
-- end)

-- toggle-font-size dpi event
-- local DPI_CHANGE_NUM = 140
-- local DPI_CHANGE_FONT_SIZE = 10.0
-- local prev_dpi = 0

-- wezterm.on('window-focus-changed', function(window, pane)
--   local dpi = window:get_dimensions().dpi
--
--   if dpi == prev_dpi then
--     return
--   end
--
--   local overrides = window:get_config_overrides() or {}
--   overrides.font_size = dpi >= DPI_CHANGE_NUM and DPI_CHANGE_FONT_SIZE or nil
--
--   window:set_config_overrides(overrides)
--
--   prev_dpi = dpi
-- end)

-- show-title-bar event
local TITLE_BAR_DISPLAY_INTERVAL = 10000

wezterm.on('show-title-bar', function(window, pane)
  local overrides = window:get_config_overrides() or {}

  overrides.window_decorations = 'TITLE | RESIZE'
  window:set_config_overrides(overrides)

  DisableTitleBar(window, TITLE_BAR_DISPLAY_INTERVAL)
end)

-- hide-title-bar event
function DisableTitleBar(window, interval)
  if interval then
    wezterm.sleep_ms(interval)
  end

  local overrides = window:get_config_overrides() or {}
  overrides.window_decorations = nil
  window:set_config_overrides(overrides)
end

wezterm.on('window-focus-changed', function(window, pane)
  if window:is_focused() then
    return
  end

  DisableTitleBar(window)
end)
