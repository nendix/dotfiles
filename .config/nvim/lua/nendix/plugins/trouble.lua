return {
	{
		"folke/trouble.nvim",
		dependencies = { "echasnovski/mini.icons", "folke/todo-comments.nvim" },
		event = "VeryLazy",
		opts = {
			focus = true,
		},
		cmd = "Trouble",
		keys = {
			{ "<leader>xw", "<CMD>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
			{
				"<leader>xD",
				"<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
				desc = "Open trouble document diagnostics",
			},
			{ "<leader>xq", "<CMD>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
			{ "<leader>xl", "<CMD>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
			{ "<leader>xt", "<CMD>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {},
	},
}
