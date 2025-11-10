local wezterm = require('wezterm')

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

