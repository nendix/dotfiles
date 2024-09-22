-- WezTerm APIs
local wezterm = require("wezterm")

-- this will old the configuration
local config = wezterm.config_builder()

-- font
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 16

-- color scheme
config.color_scheme = "Catppuccin Mocha"

-- window
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 100
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

-- config.window_close_confirmation = "NeverPrompt"
config.skip_close_confirmation_for_processes_named = { "bash", "sh", "zsh", "fish" }

-- keys
config.keys = {
	{ key = "+", mods = "CMD", action = wezterm.action.IncreaseFontSize },
	{ key = "k", mods = "CMD", action = wezterm.action.SendString("clear\n") },
}
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

return config
