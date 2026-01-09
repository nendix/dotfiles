local icons = require("icons")

-- Main battery item
local battery = sbar.add("item", "battery", {
  position = "right",
  update_freq = 60,
  icon = { padding_right = 2 },
  label = { padding_left = 2, padding_right = 4 },
  background = { drawing = false },
})

-- Popup items
local battery_time = sbar.add("item", "battery.time", {
  position = "popup.battery",
  icon = { string = icons.popup.time, padding_right = 2 },
  label = { string = "--", padding_left = 2 },
  background = { drawing = false },
})

local battery_settings = sbar.add("item", "battery.settings", {
  position = "popup.battery",
  icon = { string = icons.popup.settings, padding_right = 2 },
  label = { string = "Battery Settings", padding_left = 2 },
  background = { drawing = false },
})

-- Update main display (every 60s)
local function update_battery()
  sbar.exec("pmset -g batt", function(result)
    local charging = result:find("AC Power")
    local percent = tonumber(result:match("(%d+)%%")) or 0

    -- Calculate index (0-10)
    local index = math.min(math.floor(percent / 10), 10)

    local icon
    if charging then
      icon = icons.battery.charging[index]
    else
      icon = icons.battery.discharging[index]
    end

    battery:set({
      icon = icon,
      label = percent .. "%",
    })
  end)
end

-- Fetch popup data (only when opening - improvement #1)
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

-- Toggle popup with animation
local function toggle_popup()
  local current = battery:query().popup.drawing
  if current == "off" then
    fetch_battery_popup()
    battery:set({ popup = { blur_radius = 0, drawing = "on" } })
    sbar.animate("sin", 16, function()
      battery:set({ popup = { blur_radius = 33 } })
    end)
  else
    battery:set({ popup = { drawing = "off" } })
  end
end

-- Subscribe
battery:subscribe({"routine", "power_source_change", "system_woke"}, update_battery)
battery:subscribe("mouse.clicked", toggle_popup)
battery_settings:subscribe("mouse.clicked", function()
  sbar.exec("open 'x-apple.systempreferences:com.apple.preference.battery'")
  battery:set({ popup = { drawing = "off" } })
end)
