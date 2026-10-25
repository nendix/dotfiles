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

local battery_low_power = sbar.add("item", "battery.low_power", {
	position = "popup.battery",
	icon = { string = icons.popup.low_power, padding_right = 4 },
	label = { string = "Low Power Mode", padding_left = 4 },
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
	sbar.exec("pmset -g batt && pmset -g live", function(result, code)
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

		local low_power = result:match("lowpowermode%s+1") ~= nil
		local color = low_power and colors.yellow or (not charging and percent <= 20 and colors.red or colors.white)
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
popup.action(battery_low_power, function()
	sbar.exec("pmset -g batt && pmset -g live", function(result, code)
		if code ~= 0 then
			return
		end
		local source = result:find("AC Power") and "-c" or "-b"
		local enabled = result:match("lowpowermode%s+(%d+)")
		if not enabled then
			return
		end
		local value = enabled == "1" and "0" or "1"
		sbar.exec("/usr/bin/sudo -n /usr/bin/pmset " .. source .. " lowpowermode " .. value, function(_, status)
			if status == 0 then
				update_battery()
			end
		end)
	end)
end)
popup.action(battery_settings, function()
	sbar.exec("open 'x-apple.systempreferences:com.apple.preference.battery'")
end)
