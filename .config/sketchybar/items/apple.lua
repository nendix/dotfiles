local icons = require("icons")

-- Main Apple icon
local apple = sbar.add("item", "apple", {
	position = "left",
	icon = {
		string = icons.apple,
		font = { size = 16 },
	},
	label = { drawing = false },
	background = { padding_left = 0 },
	popup = { align = "left" },
})

-- Popup items
local about = sbar.add("item", "apple.about", {
	position = "popup.apple",
	icon = { string = icons.system.about, padding_right = 4 },
	label = { string = "About This Mac", padding_left = 4 },
	background = { drawing = false },
})

local settings = sbar.add("item", "apple.settings", {
	position = "popup.apple",
	icon = { string = icons.system.settings, padding_right = 4 },
	label = { string = "System Settings", padding_left = 4 },
	background = { drawing = false },
})

local sleep = sbar.add("item", "apple.sleep", {
	position = "popup.apple",
	icon = { string = icons.system.sleep, padding_right = 4 },
	label = { string = "Sleep", padding_left = 4 },
	background = { drawing = false },
})

local lock = sbar.add("item", "apple.lock", {
	position = "popup.apple",
	icon = { string = icons.system.lock, padding_right = 4 },
	label = { string = "Lock Screen", padding_left = 4 },
	background = { drawing = false },
})

local restart = sbar.add("item", "apple.restart", {
	position = "popup.apple",
	icon = { string = icons.system.restart, padding_right = 4 },
	label = { string = "Restart", padding_left = 4 },
	background = { drawing = false },
})

local shutdown = sbar.add("item", "apple.shutdown", {
	position = "popup.apple",
	icon = { string = icons.system.shutdown, padding_right = 4 },
	label = { string = "Shut Down", padding_left = 4 },
	background = { drawing = false },
})

-- Toggle popup with animation
local function toggle_popup()
	local current = apple:query().popup.drawing
	if current == "off" then
		apple:set({ popup = { drawing = true } })
		sbar.animate("sin", 16, function()
			apple:set({ popup = { blur_radius = 33 } })
		end)
	else
		apple:set({ popup = { drawing = false } })
	end
end

-- Close popup helper
local function close_popup()
	apple:set({ popup = { drawing = false } })
end

-- Main icon click handler
apple:subscribe("mouse.clicked", toggle_popup)

-- Popup item click handlers
about:subscribe("mouse.clicked", function()
	sbar.exec("open -a 'System Information'")
	close_popup()
end)

settings:subscribe("mouse.clicked", function()
	sbar.exec("open x-apple.systempreferences:")
	close_popup()
end)

sleep:subscribe("mouse.clicked", function()
	sbar.exec("pmset sleepnow")
	close_popup()
end)

lock:subscribe("mouse.clicked", function()
	sbar.exec('osascript -e \'tell application "System Events" to keystroke "q" using {control down, command down}\'')
	close_popup()
end)

restart:subscribe("mouse.clicked", function()
	sbar.exec("osascript -e 'tell app \"System Events\" to restart'")
	close_popup()
end)

shutdown:subscribe("mouse.clicked", function()
	sbar.exec("osascript -e 'tell app \"System Events\" to shut down'")
	close_popup()
end)
