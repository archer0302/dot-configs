local wezterm = require("wezterm")
local config = {}

config.keys = {
  { key = "\\", mods = "CTRL",       action = wezterm.action.TogglePaneZoomState },
  { key = '{',  mods = 'SHIFT|ALT',  action = wezterm.action.MoveTabRelative(-1) },
  { key = '}',  mods = 'SHIFT|ALT',  action = wezterm.action.MoveTabRelative(1) },
  { key = 'H',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'L',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'J',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'K',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
}

-- config.window_background_opacity = 0.85

config.background = {
  {
    source = { File = "/Users/archer.chang/.config/wezterm/resources/wezterm_bg_01_fixed.png" },
    hsb = { brightness = 0.02 },
    horizontal_align = "Right"
  }
}

return config;
