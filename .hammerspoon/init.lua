hs.alert.show("Config loaded")

keyUpDown = function(modifiers, key)
	hs.eventtap.keyStroke(modifiers, key, 0)
end
require("control-escape")
hs.notify.new({ title = "Hammerspoon", informativeText = "Ready to rock 🤘" }):send()
