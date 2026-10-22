local icons = require("icons")
local popup = require("helpers.popup")

-- Main WiFi item
local wifi = sbar.add("item", "wifi", {
	position = "right",
	update_freq = 60,
	background = { drawing = false },
	icon = { padding_left = 8 },
	label = { drawing = false },
})

-- Popup items
local wifi_ssid = sbar.add("item", "wifi.ssid", {
	position = "popup.wifi",
	width = 232,
	icon = { string = icons.popup.network, padding_right = 4 },
	label = { string = "Not Connected", padding_left = 4 },
	background = { drawing = false },
})

local wifi_speed = sbar.add("item", "wifi.speed", {
	position = "popup.wifi",
	width = 232,
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

-- Fetch details only when opening.
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

-- Subscribe
wifi:subscribe({ "routine", "wifi_change", "system_woke" }, update_wifi)
update_wifi()
popup.attach(wifi, fetch_wifi_popup)
popup.action(wifi_settings, function()
	sbar.exec("open 'x-apple.systempreferences:com.apple.wifi-settings'")
end)
