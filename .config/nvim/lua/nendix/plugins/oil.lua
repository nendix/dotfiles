return {
	"stevearc/oil.nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("oil").setup({
			default_file_explorer = false,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,

			lsp_file_methods = {
				timeout_ms = 2000,
				autosave_changes = true,
			},

			keymaps = {
				["g?"] = "actions.show_help",
				["<C-l>"] = "actions.select",
				["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
				["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
				["<C-p>"] = "actions.preview",
				["<ESC>"] = "actions.close", -- This is perfect for instantly closing the float
				["<C-r>"] = "actions.refresh",
				["<C-h>"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["'"] = "actions.cd",
				["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to oil dir" },
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
			use_default_keymaps = false,

			view_options = {
				show_hidden = true,
			},

			float = {
				-- Padding from the edge of the screen
				padding = 2,
				max_width = 0, -- Keep it relatively narrow to act like a quick-menu
				max_height = 0, -- 0 means it dynamically scales to fit your content
				border = "rounded",
				win_options = {
					winblend = 0, -- Change to 10 or 20 for transparency
				},
				-- Optionally override the preview window settings when Oil is floating
				preview_split = "right",
			},
		})
	end,
}
