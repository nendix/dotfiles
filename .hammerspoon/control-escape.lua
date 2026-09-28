local syntheticTag = 1128616771 -- "CESC"
local sourceUserData = hs.eventtap.event.properties.eventSourceUserData
local sendEscape = false
local controlDown = false
local controlVisible = false
local controlKeyCode

local function showControl()
	if not controlDown or controlVisible then
		return nil
	end

	controlVisible = true
	sendEscape = false
	return hs.eventtap.event.newKeyEvent(controlKeyCode, true):setProperty(sourceUserData, syntheticTag)
end

local timer = hs.timer.delayed.new(0.15, function()
	local event = showControl()
	if event then
		event:post()
	end
end)

local controlTap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(event)
	if event:getProperty(sourceUserData) == syntheticTag then
		return false
	end

	local flags = event:getFlags()
	local ctrl = flags.ctrl or false

	if ctrl ~= controlDown then
		controlDown = ctrl

		if controlDown then
			controlKeyCode = event:getKeyCode()
			controlVisible = flags.alt or flags.cmd or flags.shift or flags.fn or flags.capslock or false
			sendEscape = not controlVisible
			if sendEscape then
				timer:start()
			end
			return not controlVisible
		end

		timer:stop()
		local suppress = not controlVisible
		if sendEscape then
			hs.eventtap.keyStroke({}, "escape", 0)
		end
		sendEscape = false
		controlVisible = false
		controlKeyCode = nil
		return suppress
	end

	if controlDown then
		timer:stop()
		local controlEvent = showControl()
		return false, controlEvent and { controlEvent }
	end
	return false
end)

local keyTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function()
	if controlDown then
		timer:stop()
		local controlEvent = showControl()
		return false, controlEvent and { controlEvent }
	end
	return false
end)

controlTap:start()
keyTap:start()

return { controlTap, keyTap, timer }
