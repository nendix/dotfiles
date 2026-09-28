local callbacks = {}
local visible = {}
local escapes = 0
local timerDelay
local sourceUserData = 1

local function deliver(events)
	for _, event in ipairs(events or {}) do
		visible[#visible + 1] = { event.keyCode, event.down }
	end
end

hs = {
	timer = { delayed = { new = function(delay, callback)
		timerDelay = delay
		local running = false
		return {
			start = function() running = true end,
			stop = function() running = false end,
			expire = function()
				assert(running)
				running = false
				callback()
			end,
		}
	end } },
	eventtap = {
		event = {
			types = { flagsChanged = 1, keyDown = 2 },
			properties = { eventSourceUserData = sourceUserData },
			newKeyEvent = function(keyCode, down)
				local properties = {}
				local event = { keyCode = keyCode, down = down }
				function event:setProperty(property, value)
					properties[property] = value
					return self
				end
				function event:getProperty(property) return properties[property] or 0 end
				function event:getFlags() return { ctrl = down } end
				function event:getKeyCode() return keyCode end
				function event:post()
					local suppressed = callbacks[1](self)
					if not suppressed then deliver({ self }) end
				end
				return event
			end,
		},
		new = function(types, callback)
			callbacks[types[1]] = callback
			return { start = function() end }
		end,
		keyStroke = function(_, key)
			assert(key == "escape")
			escapes = escapes + 1
		end,
	},
}

local function flagsChanged(flags, keyCode)
	local suppressed, events = callbacks[1]({
		getFlags = function() return flags end,
		getKeyCode = function() return keyCode end,
		getProperty = function() return 0 end,
	})
	deliver(events)
	if not suppressed then
		visible[#visible + 1] = { keyCode, flags.ctrl or false }
	end
	return suppressed
end

local function keyDown()
	local suppressed, events = callbacks[2]()
	deliver(events)
	if not suppressed then
		visible[#visible + 1] = { 0, true }
	end
end

local objects = dofile(".hammerspoon/control-escape.lua")
assert(timerDelay == 0.15)

assert(flagsChanged({ ctrl = true }, 59))
assert(flagsChanged({}, 59))
assert(escapes == 1 and #visible == 0, "standalone Control must become only Escape")

assert(flagsChanged({ ctrl = true }, 59))
keyDown()
assert(not flagsChanged({}, 59))
assert(escapes == 1, "Control chord must not send Escape")
assert(#visible == 3, "Control chord must expose down, key, and up")
assert(visible[1][1] == 59 and visible[1][2] == true, "Control down must precede keyDown")
assert(visible[3][1] == 59 and visible[3][2] == false, "Control up must remain visible")

assert(flagsChanged({ ctrl = true }, 59))
objects[3]:expire()
assert(not flagsChanged({}, 59))
assert(#visible == 5, "held Control must expose down and up without replay recursion")

print("control-escape checks passed")
