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

local wifi_settings = sbar.add("item", "wifi.settings", {
	position = "popup.wifi",
	icon = { string = icons.popup.settings, padding_right = 4 },
	label = { string = "Wi-Fi Settings", padding_left = 4 },
	background = { drawing = false },
})

local popup_generation = 0
local function connection_state(summary, code)
	if code ~= 0 or type(summary) ~= "string" or summary == "" then
		return false, "Unavailable"
	end
	local connected = summary:find("LinkStatusActive%s*:%s*TRUE") ~= nil
	return connected, connected and "Unknown" or "Not Connected"
end

-- Polling keeps connection state current on macOS versions without wifi_change events.
local function update_wifi()
	sbar.exec("ipconfig getsummary en0 2>/dev/null", function(summary, code)
		local connected, status = connection_state(summary, code)
		wifi:set({ icon = connected and icons.wifi.excellent or icons.wifi.disconnected })
		if not connected then
			popup_generation = popup_generation + 1
			wifi_ssid:set({ label = status })
		end
	end)
end

-- Fetch details only when opening; late responses must not restore stale data.
local function fetch_wifi_popup()
	popup_generation = popup_generation + 1
	local generation = popup_generation
	wifi_ssid:set({ label = "Loading…" })
	sbar.exec("ipconfig getsummary en0 2>/dev/null", function(summary, code)
		if generation ~= popup_generation then return end
		local connected, status = connection_state(summary, code)
		wifi:set({ icon = connected and icons.wifi.excellent or icons.wifi.disconnected })
		if not connected then
			wifi_ssid:set({ label = status })
			return
		end

		local ssid = summary:match("%f[%w]SSID%s*:%s*([^\n]+)") or "Unknown"
		wifi_ssid:set({ label = ssid })
	end)
end

-- Subscribe
wifi:subscribe({ "routine", "wifi_change", "system_woke" }, update_wifi)
update_wifi()
popup.attach(wifi, fetch_wifi_popup)
popup.action(wifi_settings, function()
	sbar.exec("open 'x-apple.systempreferences:com.apple.wifi-settings'")
end)
