local wezterm = require("wezterm")
local config = {}

config.keys = {
  { key = "{",  mods = "SHIFT|ALT",  action = wezterm.action.MoveTabRelative(-1) },
  { key = "}",  mods = "SHIFT|ALT",  action = wezterm.action.MoveTabRelative(1) },
  { key = "H",  mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "L",  mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "J",  mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "K",  mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "`",  mods = "CTRL",       action = wezterm.action.ActivatePaneDirection("Next") },
  { key = "\\", mods = "CTRL",       action = wezterm.action.TogglePaneZoomState },
}

-- config.window_background_opacity = 0.85

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  -- Set PowerShell as the default program to launch
  config.default_prog = { "powershell.exe" }
end

config.background = {
  {
    source = { File = "/Users/archer.chang/.config/wezterm/resources/wezterm_bg_01_fixed.png" },
    hsb = { brightness = 0.02 },
    horizontal_align = "Right",
  },
}

return config
