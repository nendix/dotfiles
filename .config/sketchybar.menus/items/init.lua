require("items.menus")
require("items.rift")
require("items.calendar")
require("items.wifi")
require("items.battery")

-- Bracket for wifi + battery (from sketchybarrc line 68)
sbar.add("bracket", "stats", { "wifi", "battery" }, {})
