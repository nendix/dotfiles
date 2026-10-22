local settings = require("settings")
local icon_map = require("helpers.icon_map")

local front_app = sbar.add("item", "front_app", {
	position = "left",
	icon = {
		font = { family = "sketchybar-app-font", style = "Regular", size = 14.0 },
		padding_right = 2,
		drawing = true,
	},
	label = {
		font = { family = settings.font, style = "Regular", size = 14.0 },
		padding_left = 2,
	},

	background = { padding_left = 4 },
})

front_app:subscribe("front_app_switched", function(env)
	local app = env.INFO or ""
	local icon = icon_map(app)

	sbar.animate("sin", 16, function()
		front_app:set({
			icon = icon,
			label = app,
		})
	end)
end)
