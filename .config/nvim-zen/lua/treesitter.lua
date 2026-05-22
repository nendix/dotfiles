require("arborist").setup({
	install_popular = true,
	ensure_installed = {
		"gitignore",
	},

	overrides = {
		templ = {
			url = "https://github.com/vrischmann/tree-sitter-templ.git",
		},
	},
})

require("nvim-ts-autotag").setup()
