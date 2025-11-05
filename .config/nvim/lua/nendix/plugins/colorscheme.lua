return {
	{
		"webhooked/kanso.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanso").setup({
				bold = true,
				italics = true,
				compile = false,
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = {},
				typeStyle = {},
				transparent = true,
				dimInactive = false,
				terminalColors = true,
				theme = "ink",
			})

			vim.cmd("colorscheme kanso")
		end,
	},
}
