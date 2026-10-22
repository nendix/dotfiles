-- Run without touching live bar: lua tests/checks.lua
local root = arg[1] or "."
package.path = root .. "/?.lua;" .. root .. "/?/init.lua;" .. package.path
local items, commands = {}, {}
local workspaces = {
  { index = 0, name = "1", window_count = 3, is_active = true,
    windows = { { app_name = "Helium" }, { app_name = "Helium" }, { app_name = "Ghostty" } } },
  { index = 1, name = "2", window_count = 0, is_active = false },
}
local mode = '"default"'
local battery_result = "Now drawing from 'Battery Power'\n20%; discharging;"
local battery_code = 0
local connected = true
local wifi_code, profiler_code = 0, 0
local profiler_result = "Current Network Information:\n  Test:\n    Transmit Rate: 300"
local defer_profiler, pending_profiler = false, nil
local function merge(target, values)
  for key, value in pairs(values) do
    if type(value) == "table" and type(target[key]) == "table" then
      merge(target[key], value)
    else
      target[key] = value
    end
  end
end
sbar = {
  add = function(kind, name, properties, bracket_properties)
    if kind == "bracket" then properties = bracket_properties end
    local item = { name = name, properties = properties or {}, callbacks = {} }
    item.set_count = 0
    function item:set(values)
      self.set_count = self.set_count + 1
      merge(self.properties, values)
      if values.background and values.background.color then
        self.properties.background.drawing = true
      end
    end
    function item:subscribe(events, callback)
      if type(events) == "string" then events = { events } end
      for _, event in ipairs(events) do self.callbacks[event] = callback end
    end
    function item:query()
      local drawing = self.properties.popup and self.properties.popup.drawing
      return { popup = { drawing = (drawing == true or drawing == "on") and "on" or "off" } }
    end
    items[name] = item
    return item
  end,
  set = function(name, values) items[name]:set(values) end,
  remove = function(name) items[name] = nil end,
  animate = function(_, _, callback) callback() end,
  exec = function(command, callback)
    table.insert(commands, command)
    if not callback then return end
    if command == "rift-cli query workspaces" then callback(workspaces, 0)
    elseif command == "rift-cli query binding-mode" then callback(mode, 0)
    elseif command == "pmset -g batt" then callback(battery_result, battery_code)
    elseif command:find("ipconfig", 1, true) then
      callback(connected and "LinkStatusActive : TRUE\nBSSID : aa:bb:cc:dd:ee:ff\nSSID : Test\n" or "LinkStatusActive : FALSE\n", wifi_code)
    elseif command:find("system_profiler", 1, true) then
      if defer_profiler then pending_profiler = callback
      else callback(profiler_result, profiler_code) end
    else callback("App\nFile\n", 0) end
  end,
}
local colors = require("colors")
require("items.battery")
assert(items.battery.properties.label.string == "20%")
assert(items.battery.properties.icon.color == colors.red)
battery_result = "Now drawing from 'AC Power'\n20%; charging;"
items.battery.callbacks.power_source_change()
assert(items.battery.properties.icon.color == colors.white)
battery_result = "Now drawing from 'AC Power'"
items.battery.callbacks.routine()
assert(not items.battery.properties.drawing)
battery_code = 1
items.battery.callbacks.routine()
assert(not items.battery.properties.drawing)
commands = {}
require("items.wifi")
items.wifi.callbacks.routine()
for _, command in ipairs(commands) do assert(not command:find("system_profiler", 1, true)) end
connected = false
items.wifi.callbacks.wifi_change()
assert(items.wifi.properties.icon == require("icons").wifi.disconnected)
connected = true
items.wifi.callbacks["mouse.clicked"]()
assert(items["wifi.speed"].properties.label == "Link rate: 300 Mbps")
assert(items["wifi.ssid"].properties.label == "Test")
require("items.rift")
assert(items["space.0"].properties.drawing and not items["space.1"].properties.drawing)
assert(items["space.0"].properties.icon.padding_left == 8)
assert(items["space.0"].properties.label.string == ":helium: :ghostty:")
assert(items["space.0"].properties.background.color == colors.workspace_active)
assert(items["space.0"].properties.label.color == colors.white)
assert(items["space.0"].properties.icon.highlight_color == colors.white)
assert(items["space.1"].properties.background.color == colors.translucent_black)
assert(items["space.0"].properties.background.corner_radius == nil)
assert(items["space.0"].properties.background.border_width == nil)
assert(items["space.0"].properties.label.padding_right == 8)
assert(not items["space.1"].properties.label.drawing)
commands = {}
items["rift.watcher"].callbacks.rift_workspace_changed()
assert(#commands == 1 and commands[1] == "rift-cli query workspaces")
mode = '"service"'
commands = {}
items["rift.watcher"].callbacks.rift_binding_mode_changed()
assert(#commands == 1 and commands[1] == "rift-cli query binding-mode")
assert(items["space.0"].properties.background.border_color == colors.border)
assert(items["space.1"].properties.background.border_color == colors.translucent_red)
assert(items["space.0"].properties.background.drawing)
assert(not items.spaces)
table.insert(workspaces, { index = 2, name = "3", window_count = 1, is_active = false })
commands = {}
items["rift.watcher"].callbacks.rift_windows_changed()
assert(commands[#commands] == "sketchybar --reorder space.0 space.1 space.2 front_app")
assert(items["space.2"].properties.background.border_color == colors.translucent_red)
workspaces[1].is_active = false
workspaces[2].is_active = true
items["rift.watcher"].callbacks.rift_workspace_changed()
assert(items["space.1"].properties.drawing)
assert(items["space.1"].properties.background.color == colors.workspace_active)
workspaces[2].is_active = false
items["rift.watcher"].callbacks.rift_workspace_changed()
assert(not items["space.1"].properties.drawing)
local real_date = os.date
local test_date = { year = 2025, month = 8, day = 31 }
os.date = function(format, time)
  if format == "*t" and time == nil then
    return { year = test_date.year, month = test_date.month, day = test_date.day }
  end
  return real_date(format, time)
end
require("items.calendar")
items.calendar.callbacks["mouse.clicked"]()
assert(items["calendar.month"].properties.label.string == "August 2025")
assert(not items["calendar.navigation"] and not items["calendar.previous"] and not items["calendar.next"])
assert(items["calendar.month"].properties.align == "center")
assert(items["calendar.month"].properties.label.font.style == "Bold")
assert(items["calendar.month"].properties.label.color == colors.white)
assert(items["calendar.days6"].properties.icon.font.style == "Bold")
assert(items["calendar.days6"].properties.icon.color == colors.white)
assert(items["calendar.days6"].properties.icon.drawing)
assert(items["calendar.days6"].properties.icon.string == " 31 ")
assert(items["calendar.days6"].properties.icon.padding_left == 8)
local heading_updates = items["calendar.month"].set_count
items.calendar.callbacks.routine()
assert(items["calendar.month"].set_count == heading_updates)
assert(items.calendar.properties.update_freq == 30)
test_date = { year = 2024, month = 2, day = 1 }
items.calendar.callbacks.routine()
assert(items["calendar.month"].set_count == heading_updates + 1)
assert(not items["calendar.days6"].properties.icon.drawing)
assert(items["calendar.month"].properties.label.string == "February 2024")
assert(items["calendar.days5"].properties.label.string:find("29", 1, true))
assert(not items["calendar.days5"].properties.label.string:find("30", 1, true))
os.date = real_date
local parents = { items.calendar, items.wifi, items.battery }
for _, parent in ipairs(parents) do
  for _, other in ipairs(parents) do other:set({ popup = { drawing = true } }) end
  parent:set({ popup = { drawing = false } })
  parent.callbacks["mouse.clicked"]()
  assert(parent:query().popup.drawing == "on")
  for _, other in ipairs(parents) do
    if other ~= parent then assert(other:query().popup.drawing == "off") end
  end
  parent.callbacks["mouse.clicked"]()
  assert(parent:query().popup.drawing == "off")
  for _, event in ipairs({ "mouse.exited", "mouse.exited.global", "front_app_switched" }) do
    parent.callbacks["mouse.clicked"]()
    parent.callbacks[event]()
    for _, other in ipairs(parents) do assert(other:query().popup.drawing == "off") end
  end
end
for _, name in ipairs({ "wifi.settings", "battery.settings" }) do
  local action = items[name]
  assert(action.properties.width == 224)
  assert(action.properties.background.padding_left == 4)
  assert(action.properties.background.padding_right == 4)
  assert(action.properties.background.height == 22)
  assert(action.properties.background.corner_radius == 5)
  assert(not action.properties.background.drawing)
  action.callbacks["mouse.entered"]()
  assert(action.properties.background.drawing)
  assert(action.properties.background.color == colors.hover)
  action.callbacks["mouse.exited"]()
  assert(not action.properties.background.drawing)
  for _, parent in ipairs(parents) do parent:set({ popup = { drawing = true } }) end
  action.callbacks["mouse.clicked"]()
  for _, parent in ipairs(parents) do assert(parent:query().popup.drawing == "off") end
  assert(commands[#commands]:find("open 'x-apple.systempreferences:", 1, true))
end
-- Failed queries clear prior successful details rather than retaining old values.
items.wifi.callbacks["mouse.clicked"]()
assert(items["wifi.speed"].properties.label == "Link rate: 300 Mbps")
wifi_code = 1
items.wifi.callbacks.routine()
assert(items["wifi.ssid"].properties.label == "Unavailable")
assert(items["wifi.speed"].properties.label == "Link rate: --")
assert(items.wifi.properties.icon == require("icons").wifi.disconnected)
items.wifi.callbacks["mouse.clicked"]() -- Close.
items.wifi.callbacks["mouse.clicked"]() -- Open with failed summary.
assert(items["wifi.ssid"].properties.label == "Unavailable")
wifi_code, profiler_code = 0, 1
items.wifi.callbacks["mouse.clicked"]()
items.wifi.callbacks["mouse.clicked"]()
assert(items["wifi.ssid"].properties.label == "Test")
assert(items["wifi.speed"].properties.label == "Link rate: --")
profiler_code, profiler_result = 0, "No current network information"
items.wifi.callbacks["mouse.clicked"]()
items.wifi.callbacks["mouse.clicked"]()
assert(items["wifi.speed"].properties.label == "Link rate: --")
-- A delayed link-rate response cannot undo a disconnect.
defer_profiler = true
items.wifi.callbacks["mouse.clicked"]()
items.wifi.callbacks["mouse.clicked"]()
assert(pending_profiler)
connected = false
items.wifi.callbacks.wifi_change()
pending_profiler("Current Network Information:\nTransmit Rate: 999", 0)
assert(items["wifi.ssid"].properties.label == "Not Connected")
assert(items["wifi.speed"].properties.label == "Link rate: --")
print("Checks passed: " .. root)
