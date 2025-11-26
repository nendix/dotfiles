return {
	{
		"webhooked/kanso.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanso").setup({
				theme = "ink",
				transparent = true,
			})

			-- vim.cmd.colorscheme("kanso")
		end,
	},
	{
		dir = "/Users/daniele/Developer/zen.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("zen").setup({
				transparent = true,
			})
			vim.cmd.colorscheme("zen")
		end,
	},
}
