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
		"nendix/zen.nvim",
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
