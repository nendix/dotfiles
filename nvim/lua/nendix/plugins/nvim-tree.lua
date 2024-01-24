-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 40,
	},
	renderer = {
		icons = {
			glyphs = {
				folder = {},
			},
			show = {
				file = true,
				folder = true,
				folder_arrow = false,
				git = true,
			},
		},
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})
