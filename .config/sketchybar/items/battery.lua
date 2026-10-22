local icons = require("icons")
local colors = require("colors")
local popup = require("helpers.popup")

-- Main battery item
local battery = sbar.add("item", "battery", {
	position = "right",
	update_freq = 60,
	icon = { padding_right = 2 },
	label = { padding_left = 2, padding_right = 6 },
	background = { drawing = false },
})

-- Popup items
local battery_time = sbar.add("item", "battery.time", {
	position = "popup.battery",
	width = 232,
	icon = { string = icons.popup.time, padding_right = 4 },
	label = { string = "--", padding_left = 4 },
	background = { drawing = false },
})

local battery_settings = sbar.add("item", "battery.settings", {
	position = "popup.battery",
	icon = { string = icons.popup.settings, padding_right = 4 },
	label = { string = "Battery Settings", padding_left = 4 },
	background = { drawing = false },
})

-- Update main display (every 60s)
local function update_battery()
	sbar.exec("pmset -g batt", function(result, code)
		if code ~= 0 then
			return
		end
		local charging = result:find("AC Power")
		local percent = tonumber(result:match("(%d+)%%"))
		if not percent then
			battery:set({ drawing = false })
			return
		end

		-- Calculate index (0-10)
		local index = math.min(math.floor(percent / 10), 10)

		local icon
		if charging then
			icon = icons.battery.charging[index]
		else
			icon = icons.battery.discharging[index]
		end

		local color = not charging and percent <= 20 and colors.red or colors.white
		battery:set({
			drawing = true,
			icon = { string = icon, color = color },
			label = { string = percent .. "%", color = color },
		})
	end)
end

-- Fetch details only when opening.
local function fetch_battery_popup()
	sbar.exec("pmset -g batt", function(result)
		local charging = result:find("AC Power")
		local time_remaining

		if charging then
			time_remaining = "Plugged in"
		else
			time_remaining = result:match("(%d+:%d+ remaining)") or "--"
		end

		battery_time:set({ label = time_remaining })
	end)
end

-- Subscribe
battery:subscribe({ "routine", "power_source_change", "system_woke" }, update_battery)
popup.attach(battery, fetch_battery_popup)
update_battery()
popup.action(battery_settings, function()
	sbar.exec("open 'x-apple.systempreferences:com.apple.preference.battery'")
end)
