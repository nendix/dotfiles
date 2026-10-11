local icons = require("icons")

-- Main WiFi item
local wifi = sbar.add("item", "wifi", {
	position = "right",
	update_freq = 60,
	background = { drawing = false },
	icon = { padding_left = 2 },
	label = { drawing = false },
})

-- Popup items
local wifi_ssid = sbar.add("item", "wifi.ssid", {
	position = "popup.wifi",
	icon = { string = icons.popup.network, padding_right = 4 },
	label = { string = "Not Connected", padding_left = 4 },
	background = { drawing = false },
})

local wifi_speed = sbar.add("item", "wifi.speed", {
	position = "popup.wifi",
	icon = { string = icons.popup.speed, padding_right = 4 },
	label = { string = "-- Mbps", padding_left = 4 },
	background = { drawing = false },
})

local wifi_settings = sbar.add("item", "wifi.settings", {
	position = "popup.wifi",
	icon = { string = icons.popup.settings, padding_right = 4 },
	label = { string = "Wi-Fi Settings", padding_left = 4 },
	background = { drawing = false },
})

-- Update main icon (every 60s)
local function update_wifi()
	sbar.exec("ipconfig getsummary en0 2>/dev/null", function(summary)
		local connected = summary:find("LinkStatusActive.*TRUE")

		wifi:set({ icon = connected and icons.wifi.excellent or icons.wifi.disconnected })
	end)
end

-- Fetch popup data (only when opening - improvement #1)
local function fetch_wifi_popup()
	sbar.exec("ipconfig getsummary en0 2>/dev/null", function(summary)
		local connected = summary:find("LinkStatusActive.*TRUE")

		if not connected then
			wifi_ssid:set({ label = "Not Connected" })
			wifi_speed:set({ label = "--" })
			return
		end

		local ssid = summary:match("[^B]SSID : ([^\n]+)") or "Unknown"
		wifi_ssid:set({ label = ssid })

		sbar.exec(
			"system_profiler SPAirPortDataType 2>/dev/null | grep -A 10 'Current Network Information' | head -15",
			function(info)
				local speed = info:match("Transmit Rate: (%d+)")
				if speed then
					wifi_speed:set({ label = speed .. " Mbps" })
				else
					wifi_speed:set({ label = "--" })
				end
			end
		)
	end)
end

-- Toggle popup with animation
local function toggle_popup()
	local current = wifi:query().popup.drawing
	if current == "off" then
		fetch_wifi_popup()
		wifi:set({ popup = { drawing = "on" } })
	else
		wifi:set({ popup = { drawing = "off" } })
	end
end

-- Subscribe
wifi:subscribe({ "routine", "wifi_change", "system_woke" }, update_wifi)
update_wifi()
wifi:subscribe("mouse.clicked", toggle_popup)
wifi_settings:subscribe("mouse.clicked", function()
	sbar.exec("open 'x-apple.systempreferences:com.apple.wifi-settings'")
	wifi:set({ popup = { drawing = "off" } })
end)
