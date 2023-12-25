-- config reload
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", function()
	hs.reload()
end)
hs.alert.show("Config loaded")

-- show a clock
hs.loadSpoon("AClock")
spoon.AClock:init()
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "C", function()
	spoon.AClock:toggleShow()
end)

-- caffeine extension
-- function setCaffeineDisplay(state)
-- 	if state then
-- 		caffeine:setTitle("AWAKE")
-- 	else
-- 		caffeine:setTitle("SLEEPY")
-- 	end
-- end
--
-- function caffeineClicked()
-- 	setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
-- end
--
-- if caffeine then
-- 	caffeine:setClickCallback(caffeineClicked)
-- 	setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
-- end

keyUpDown = function(modifiers, key)
	hs.eventtap.keyStroke(modifiers, key, 0)
end
require("control-escape")
hs.notify.new({ title = "Hammerspoon", informativeText = "Ready to rock 🤘" }):send()
