local colors = require("colors")
local settings = require("settings")

sbar.default({
	updates = "when_shown",
	blur_radius = 25,
	icon = {
		font = { family = settings.font, style = "Regular", size = 14.0 },
		color = colors.white,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
	label = {
		font = { family = settings.font, style = "Regular", size = 14.0 },
		color = colors.white,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
	background = {
		height = 24,
		color = colors.translucent_black,
		border_width = 1,
		border_color = colors.border,
		corner_radius = 8,
	},
	popup = {
		y_offset = 4,
		background = {
			drawing = true,
			color = colors.translucent_grey,
			border_color = colors.border,
			border_width = 1,
			corner_radius = 8,
			padding_left = 4,
			padding_right = 4,
		},
		blur_radius = 20,
		align = "center",
	},
})
