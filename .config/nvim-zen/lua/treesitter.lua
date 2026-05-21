require("tree-sitter-manager").setup({
	-- 1. The parsers you want automatically downloaded
	ensure_installed = {
		"json",
		"javascript",
		"html",
		"css",
		"c",
		"markdown",
		"markdown_inline",
		"go",
		"java",
		"bash",
		"lua",
		"vim",
		"vimdoc",
		"gitignore",
		"python",
	},

	-- 2. Automatically install missing parsers when editing a new file type
	auto_install = true,

	-- 3. Ensure native treesitter highlighting is enabled
	highlight = true,

	-- 4. Your custom parser logic replaces the old core API calls
	languages = {
		templ = {
			url = "https://github.com/vrischmann/tree-sitter-templ.git",
			files = { "src/parser.c", "src/scanner.c" },
			branch = "master",
		},
	},
})

require("nvim-ts-autotag").setup()
