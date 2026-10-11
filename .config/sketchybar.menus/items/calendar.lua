local settings = require("settings")

-- Main calendar item
local calendar = sbar.add("item", "calendar", {
  position = "right",
  icon = { drawing = false },
  update_freq = 1,
  background = { padding_right = 0 },
  popup = { align = "right" },
})

-- Popup items (7 lines for cal output)
local popup_items = {}
local popup_names = { "month", "week", "days1", "days2", "days3", "days4", "days5" }

for _, name in ipairs(popup_names) do
  popup_items[name] = sbar.add("item", "calendar." .. name, {
    position = "popup.calendar",
    width = 156,
    icon = { drawing = false },
    background = { drawing = false },
  })
end

-- Update main display (every 1s)
local function update_calendar()
  calendar:set({ label = os.date("%d %b %H:%M") })
end

-- Fetch popup data (only when opening - improvement #1)
local function fetch_calendar_popup()
  sbar.exec("cal", function(result)
    local lines = {}
    for line in result:gmatch("[^\n]+") do
      table.insert(lines, line)
    end

    local mapping = {
      month = lines[1] or "",
      week = lines[2] or "",
      days1 = lines[3] or "",
      days2 = lines[4] or "",
      days3 = lines[5] or "",
      days4 = lines[6] or "",
      days5 = lines[7] or "",
    }

    for name, label in pairs(mapping) do
      popup_items[name]:set({ label = label })
    end
  end)
end

-- Toggle popup with animation
local function toggle_popup()
  local current = calendar:query().popup.drawing
  if current == "off" then
    fetch_calendar_popup()
    calendar:set({ popup = { blur_radius = 0, drawing = "on" } })
    sbar.animate("sin", 16, function()
      calendar:set({ popup = { blur_radius = 33 } })
    end)
  else
    calendar:set({ popup = { drawing = "off" } })
  end
end

-- Subscribe
calendar:subscribe("routine", update_calendar)
calendar:subscribe("mouse.clicked", toggle_popup)
