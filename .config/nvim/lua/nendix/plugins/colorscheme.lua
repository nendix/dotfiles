return {
	{
		"cdmill/neomodern.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("neomodern").setup({
				theme = "hojicha",
				plain_float = true,
				transparent = true,
				favor_treesitter_hl = true,
				code_style = {
					comments = "italic",
					conditionals = "none",
					functions = "none",
					keywords = "italic",
					headings = "bold", -- Markdown headings
					operators = "none",
					keyword_return = "none",
					strings = "none",
					variables = "none",
				},
				highlights = {
					IblIndent = { fg = "#333333", fmt = "nocombine" },
				},
			})
			vim.cmd.colorscheme("hojicha")
		end,
	},
}
