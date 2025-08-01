local wezterm = require("wezterm")
local config = {}

config.keys = {
  { key = "\\", mods = "CTRL",      action = wezterm.action.TogglePaneZoomState },
  { key = '{',  mods = 'SHIFT|ALT', action = wezterm.action.MoveTabRelative(-1) },
  { key = '}',  mods = 'SHIFT|ALT', action = wezterm.action.MoveTabRelative(1) },
}

config.window_background_opacity = 0.9

return config;
