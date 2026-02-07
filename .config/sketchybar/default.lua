local colors = require("colors")
local settings = require("settings")

sbar.default({
	updates = "when_shown",
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
		height = 26,
		color = colors.black,
		border_width = 1,
		border_color = colors.border,
		padding_right = 4,
		padding_left = 4,
		corner_radius = 12,
	},
	popup = {
		background = {
			drawing = true,
			color = colors.grey,
			border_color = colors.border,
			border_width = 1,
			corner_radius = 8,
			padding_left = 4,
			padding_right = 4,
		},
		blur_radius = 33,
		align = "center",
	},
})
