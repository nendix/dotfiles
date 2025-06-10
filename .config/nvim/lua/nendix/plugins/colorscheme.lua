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
				colors = {
					palette = {},
					theme = { zen = {}, pearl = {}, ink = {}, all = {} },
				},
				overrides = function(colors)
					return {}
				end,
				theme = "ink",
				background = {
					dark = "ink",
					light = "pearl",
				},
			})

			vim.cmd("colorscheme kanso")
		end,
	},
}
