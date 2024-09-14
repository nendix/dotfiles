return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		event = { "BufReadPre", "BufNewFile" },
		ft = { "markdown" },
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		event = { "BufReadPre", "BufNewFile" },
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.keymap.set("n", "<leader>mp", "<CMD>MarkdownPreviewToggle <CR>", { desc = "Toggle markdown preview" })
		end,
	},
}
