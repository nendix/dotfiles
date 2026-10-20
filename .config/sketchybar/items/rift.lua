local colors = require("colors")
local icon_map = require("helpers.icon_map")

sbar.add("event", "rift_workspace_changed")
sbar.add("event", "rift_windows_changed")
sbar.add("event", "rift_binding_mode_changed")

local spaces = {}
local front_app_loaded = false
local border_color = colors.border
local watcher = sbar.add("item", "rift.watcher", {
	drawing = false,
	updates = true,
	update_freq = 10,
})

local function update_mode()
	sbar.exec("rift-cli query binding-mode", function(mode, code)
		if code ~= 0 or type(mode) ~= "string" then
			return
		end
		mode = mode:match('^%s*"(.-)"%s*$')
		if not mode then
			return
		end
		border_color = mode == "service" and colors.translucent_red or colors.border
		for _, space in pairs(spaces) do
			space:set({ background = { border_color = border_color } })
		end
	end)
end

local function refresh()
	sbar.exec("rift-cli query workspaces", function(workspaces, exit_code)
		if exit_code ~= 0 or type(workspaces) ~= "table" then
			return
		end

		local seen = {}
		local changed = false
		for _, workspace in ipairs(workspaces) do
			local index = workspace.index
			seen[index] = true
			if not spaces[index] then
				local space = sbar.add("item", "space." .. index, {
					position = "left",
					icon = {
						string = workspace.name,
						color = colors.white,
						padding_left = 4,
						padding_right = 4,
					},
					label = {
						font = { family = "sketchybar-app-font", style = "Regular", size = 14.0 },
						padding_left = 8,
					},
					background = {
						drawing = true,
						padding_right = 4,
						border_color = border_color,
					},
				})
				space:subscribe("mouse.clicked", function()
					sbar.exec("rift-cli execute workspace switch " .. index)
				end)
				spaces[index] = space
				changed = true
			end
			local app_icons, apps = {}, {}
			for _, window in ipairs(workspace.windows or {}) do
				local app = window.app_name
				if app and not apps[app] then
					apps[app] = true
					table.insert(app_icons, icon_map(app))
				end
			end
			local occupied = workspace.window_count > 0
			spaces[index].is_active = workspace.is_active
			spaces[index]:set({
				drawing = occupied,
				background = {
					color = workspace.is_active and colors.workspace_active or colors.translucent_black,
					border_color = workspace.is_active and colors.border or border_color,
				},
				icon = {
					string = workspace.name,
					highlight = workspace.is_active,
					highlight_color = colors.white,
					padding_left = 8,
					padding_right = #app_icons > 0 and 6 or 8,
				},
				label = {
					drawing = #app_icons > 0,
					string = table.concat(app_icons, " "),
					color = colors.white,
					padding_right = 8,
				},
			})
		end

		for index, space in pairs(spaces) do
			if not seen[index] then
				sbar.remove(space.name)
				spaces[index] = nil
				changed = true
			end
		end

		if not front_app_loaded then
			require("items.front_app")
			front_app_loaded = true
		end

		if changed then
			local names = {}
			for _, workspace in ipairs(workspaces) do
				table.insert(names, "space." .. workspace.index)
			end
			table.insert(names, "front_app")
			sbar.exec("sketchybar --reorder " .. table.concat(names, " "))
		end
	end)
end

local function reconnect()
	-- Rift deduplicates subscriptions; watchdog recovers after WM restarts.
	for _, event in ipairs({ "workspace_changed", "windows_changed", "binding_mode_changed" }) do
		sbar.exec(
			"rift-cli subscribe cli --event "
				.. event
				.. " --command /opt/homebrew/bin/sketchybar --args --trigger --args rift_"
				.. event
		)
	end
	update_mode()
	refresh()
end

watcher:subscribe({ "routine", "system_woke" }, reconnect)
watcher:subscribe({ "rift_workspace_changed", "rift_windows_changed" }, refresh)
watcher:subscribe("rift_binding_mode_changed", update_mode)
reconnect()
