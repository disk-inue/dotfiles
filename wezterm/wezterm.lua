require("format")
require("status")
require("event")

local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- keybinds
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = ",", mods = "CTRL", timeout_milliseconds = 2000 }

-- colors
config.color_scheme = "nord"
config.window_background_opacity = 0.93

-- font
config.font = require("wezterm").font("Firge35Nerd Console")
config.font_size = 13.0
config.window_frame = {
  font = wezterm.font({ family = "Roboto", weight = "Bold" }),
  font_size = 11.0,
}

-- status
config.status_update_interval = 1000

-- window decorations
-- config.window_decorations = "RESIZE"

-- mouse binds
config.mouse_bindings = require("mousebinds").mouse_bindings

return config
