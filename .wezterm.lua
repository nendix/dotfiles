-- WezTerm APIs
local wezterm = require("wezterm")

-- this will old the configuration
local config = wezterm.config_builder()

-- font
config.font = wezterm.font("MesloLGS NF")
config.font_size = 16

-- color scheme
config.color_scheme = "Catppuccin Mocha"

-- window
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 100
config.window_padding = {
	left = 12,
	right = 12,
	top = 12,
	bottom = 12,
}

-- keys
config.keys = {
	{
		key = "+",
		mods = "SUPER",
		action = wezterm.action.IncreaseFontSize,
	},
}
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

return config