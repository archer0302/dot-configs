local wezterm = require("wezterm")
local config = {}

config.keys = {
    {
        key = "\\",
        mods = "CTRL",
        action = wezterm.action.TogglePaneZoomState,
    },
}

return config;
