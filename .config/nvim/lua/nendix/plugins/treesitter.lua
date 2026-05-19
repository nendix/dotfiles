return {
	{
		"romus204/tree-sitter-manager.nvim",
		dependencies = {},
		config = function()
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
		end,
	},
	-- 1. Auto-close and auto-rename HTML/JSX tags
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- 3. Sticky scroll (keeps function signatures visible at the top of the screen)
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("treesitter-context").setup({
				max_lines = 3, -- How many lines the window should span
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				separator = "-", -- Separator between context and content
			})
		end,
	},
}
