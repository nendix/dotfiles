return {
	{ "nvim-tree/nvim-web-devicons" }, -- vs-code icons
	{ "nvim-lua/plenary.nvim" }, -- lua functions that many plugins use
	{ "christoomey/vim-tmux-navigator", event = "VeryLazy" }, -- tmux & split window navigation
	{ "szw/vim-maximizer", event = "VeryLazy" }, -- maximize split
	{ "mg979/vim-visual-multi", event = "VeryLazy" }, -- multiple cursors
	{ "mbbill/undotree", event = "VeryLazy" },
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {},
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			vim.keymap.set("n", "s", "<Nop>", { noremap = true, silent = true }) -- disable s
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.operators",
		version = "*",
		config = function()
			require("mini.operators").setup()
		end,
	},
	{
		"echasnovski/mini.ai",
		version = "*",
		config = function()
			require("mini.ai").setup()
		end,
	},
}
