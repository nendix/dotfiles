return {
	"stevearc/oil.nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,

			delete_to_trash = true,

			skip_confirm_for_simple_edits = true,

			lsp_file_methods = {
				-- Time to wait for LSP file operations to complete before skipping
				timeout_ms = 2000,
				-- Set to true to autosave buffers that are updated with LSP willRenameFiles
				-- Set to "unmodified" to only save unmodified buffers
				autosave_changes = true,
			},

			keymaps = {
				["g?"] = "actions.show_help",
				["<C-l>"] = "actions.select",
				["<C-s>"] = {
					"actions.select",
					opts = { vertical = true },
					desc = "Open the entry in a vertical split",
				},
				["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
				["<C-p>"] = "actions.preview",
				["<ESC>"] = "actions.close",
				["<C-r>"] = "actions.refresh",
				["<C-h>"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["'"] = "actions.cd",
				["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
			use_default_keymaps = false,

			view_options = {
				show_hidden = true,
			},
		})
	end,
}
