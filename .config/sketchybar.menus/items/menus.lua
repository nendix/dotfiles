local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local icon_map = require("helpers.icon_map")

local CONFIG_DIR = os.getenv("CONFIG_DIR") or os.getenv("HOME") .. "/.config/sketchybar"
local MENUS_HELPER = CONFIG_DIR .. "/helpers/menus/bin/menus"
local MAX_MENU_ITEMS = 15
local MAX_POPUP_ITEMS = 25

-- State tracking
local menus_mode = false
local current_app = ""

-- Custom event for toggling modes
sbar.add("event", "toggle_menus")

-- Toggle between workspaces and application menus
local toggle = sbar.add("item", "menu.toggle", {
	position = "left",
	icon = {
		string = icons.menu.collapsed,
		font = { size = 16 },
		padding_left = 8,
		padding_right = 8,
	},
	label = { drawing = false },
	background = { drawing = true },
})

-- Create menu bar items (hidden by default)
local menu_items = {}
local popup_items = {} -- popup_items[menu_index][popup_index]

for i = 1, MAX_MENU_ITEMS do
	local menu_item = sbar.add("item", "menu." .. i, {
		position = "left",
		drawing = false,
		icon = { drawing = false },
		label = {
			font = { family = settings.font, style = "Regular", size = 14.0 },
			padding_left = 6,
			padding_right = 6,
		},
		background = {
			drawing = false,
			padding_left = 0,
			padding_right = 0,
		},
		popup = { align = "left" },
	})

	-- Store the menu index for click handling
	menu_item.menu_index = i
	menu_items[i] = menu_item

	-- Create popup items for this menu (only for menus 2+, menu 1 is app name)
	if i >= 1 then
		popup_items[i] = {}
		for j = 1, MAX_POPUP_ITEMS do
			local popup_item = sbar.add("item", "menu." .. i .. "." .. j, {
				position = "popup.menu." .. i,
				drawing = false,
				icon = { drawing = false },
				label = {
					font = { family = settings.font, style = "Regular", size = 13.0 },
					padding_left = 8,
					padding_right = 8,
				},
				background = { drawing = false },
			})

			-- Store indices for click handling
			popup_item.menu_index = i
			popup_item.item_index = j
			popup_item.actual_index = nil -- Will be set when populating
			popup_item.is_disabled = false

			popup_item:subscribe("mouse.clicked", function()
				if popup_item.is_disabled or popup_item.actual_index == nil then
					return
				end
				-- Close popup first
				menu_items[i]:set({ popup = { drawing = false } })
				-- Click the submenu item (menu_index is 1-based in our items, but helper uses different indexing)
				-- Our menu.1 = app name (helper index 1), menu.2 = File (helper index 2), etc.
				sbar.exec(MENUS_HELPER .. " -s " .. i .. " " .. popup_item.actual_index)
			end)

			popup_items[i][j] = popup_item
		end
	end
end

-- Create bracket for menu items (will be shown/hidden with mode)
local menus_bracket = sbar.add("bracket", "menus", {
	"menu.1",
	"menu.2",
	"menu.3",
	"menu.4",
	"menu.5",
	"menu.6",
	"menu.7",
	"menu.8",
	"menu.9",
	"menu.10",
	"menu.11",
	"menu.12",
	"menu.13",
	"menu.14",
	"menu.15",
}, {
	background = { drawing = false },
})

-- Function to close all menu popups
local function close_all_popups()
	for i = 1, MAX_MENU_ITEMS do
		menu_items[i]:set({ popup = { drawing = false } })
	end
end

-- Function to populate and show popup for a menu
local function show_menu_popup(menu_index)
	-- Close any other open popups first
	close_all_popups()

	local menu_item = menu_items[menu_index]
	local popups = popup_items[menu_index]
	if not popups then
		return
	end

	-- Get submenu items from helper
	sbar.exec(MENUS_HELPER .. " -l " .. menu_index, function(result)
		if not menus_mode then return end
		local items = {}
		local actual_indices = {} -- Track actual indices including separators

		local actual_idx = 0
		for line in result:gmatch("[^\r\n]*") do
			actual_idx = actual_idx + 1
			if line ~= "" then
				-- Not a separator, add to items
				local is_disabled = false
				local title = line

				-- Check for [disabled] prefix
				if line:match("^%[disabled%]") then
					is_disabled = true
					title = line:gsub("^%[disabled%]", "")
				end

				table.insert(items, {
					title = title,
					disabled = is_disabled,
					actual_index = actual_idx - 1, -- 0-based for helper
				})
			end
			-- Skip empty lines (separators)
		end

		-- Populate popup items
		for j = 1, MAX_POPUP_ITEMS do
			local popup = popups[j]
			if j <= #items then
				local item = items[j]
				popup.actual_index = item.actual_index
				popup.is_disabled = item.disabled

				popup:set({
					drawing = true,
					label = {
						string = item.title,
						color = item.disabled and 0x66e0e0e0 or colors.white,
					},
				})
			else
				popup:set({ drawing = false })
				popup.actual_index = nil
				popup.is_disabled = false
			end
		end

		-- Show popup with animation
		menu_item:set({ popup = { drawing = true } })
		sbar.animate("sin", 16, function()
			menu_item:set({ popup = { blur_radius = 33 } })
		end)
	end)
end

-- Set up click handlers for menu bar items (including app name at index 1)
for i = 1, MAX_MENU_ITEMS do
	menu_items[i]:subscribe("mouse.clicked", function()
		local menu_item = menu_items[i]
		local current = menu_item:query().popup.drawing
		if current == "off" then
			show_menu_popup(i)
		else
			menu_item:set({ popup = { drawing = false } })
		end
	end)
end

-- Function to update menu bar items from current app
local function update_menus()
	if not menus_mode then
		return
	end

	sbar.exec(MENUS_HELPER .. " -l", function(result)
		if not menus_mode then return end
		local menus = {}
		for line in result:gmatch("[^\r\n]+") do
			table.insert(menus, line)
		end

		-- First item is app name with icon, rest are menu items
		for i = 1, MAX_MENU_ITEMS do
			local menu_item = menu_items[i]
			if i <= #menus then
				local menu_name = menus[i]
				if i == 1 then
					-- First item: app name with bold label, no icon
					menu_item:set({
						drawing = true,
						icon = { drawing = false },
						label = {
							string = menu_name,
							font = { family = settings.font, style = "Bold", size = 14.0 },
						},
					})
				else
					-- Menu items: just label, icon drawing off
					menu_item:set({
						drawing = true,
						icon = { drawing = false },
						label = {
							string = menu_name,
							font = { family = settings.font, style = "Regular", size = 14.0 },
						},
					})
				end
			else
				menu_item:set({
					drawing = false,
					icon = { drawing = false },
				})
			end
		end

		-- Show bracket if we have menu items
		if #menus > 0 then
			menus_bracket:set({ background = { drawing = true } })
		end
	end)
end

-- Function to hide all menu items
local function hide_menus()
	close_all_popups()
	for i = 1, MAX_MENU_ITEMS do
		menu_items[i]:set({
			drawing = false,
			icon = { drawing = false },
		})
	end
	menus_bracket:set({ background = { drawing = false } })
end

-- Function to show spaces and front_app
local function show_spaces()
	require("items.rift").set_visible(true)
end

-- Function to hide spaces and front_app
local function hide_spaces()
	require("items.rift").set_visible(false)
end

-- Toggle mode handler
local function toggle_modes()
	menus_mode = not menus_mode

	if menus_mode then
		-- Switch to menus mode
		sbar.animate("sin", 12, function()
			toggle:set({ icon = { string = icons.menu.expanded } })
		end)
		hide_spaces()
		update_menus()
	else
		-- Switch to spaces mode
		sbar.animate("sin", 12, function()
			toggle:set({ icon = { string = icons.menu.collapsed } })
		end)
		hide_menus()
		show_spaces()
	end
end

-- Click handler for toggle button
toggle:subscribe("mouse.clicked", toggle_modes)

-- Custom event handler (in case we want to trigger toggle from elsewhere)
toggle:subscribe("toggle_menus", toggle_modes)

-- Update menus when front app changes (only if in menus mode)
toggle:subscribe("front_app_switched", function(env)
	current_app = env.INFO or ""
	if menus_mode then
		close_all_popups()
		update_menus()
	end
end)
