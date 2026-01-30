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

-- キーボードプロトコルの最新化
config.enable_kitty_keyboard = true

-- colors
config.color_scheme = "nord"
config.window_background_opacity = 0.93

-- font
config.font = wezterm.font("Firge35Nerd Console")
config.font_size = 13.0
config.line_height = 1.0
config.window_frame = {
  font = wezterm.font({ family = "Roboto", weight = "Bold" }),
  font_size = 11.0,
}

-- パフォーマンス設定
config.max_fps = 120
config.animation_fps = 60
config.front_end = "WebGpu"

-- UI設定
config.hide_tab_bar_if_only_one_tab = false
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false

-- カーソル設定
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 700
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- スクロールバック
config.scrollback_lines = 10000

-- tmux自動起動（新規ウィンドウごとに新しいセッションを作成）
config.default_prog = { "/opt/homebrew/bin/tmux", "new-session" }

-- status
config.status_update_interval = 1000

-- window decorations
-- config.window_decorations = "RESIZE"

-- mouse binds
config.mouse_bindings = require("mousebinds").mouse_bindings

return config
