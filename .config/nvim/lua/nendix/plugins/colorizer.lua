return {
	"catgoose/nvim-colorizer.lua",
	lazy = true, -- Don't load automatically
	cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" }, -- Load when these commands are used
	keys = {
		{ "<leader>ct", "<CMD>ColorizerToggle<CR>", desc = "Toggle colorizer" },
	},
	opts = {
		user_default_options = {
			mode = "background", -- Set the display mode
		},
	},
}
