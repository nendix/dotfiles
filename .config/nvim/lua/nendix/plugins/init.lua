return {
	{ "nvim-lua/plenary.nvim" }, -- lua functions that many plugins use
	{ "christoomey/vim-tmux-navigator", event = "VeryLazy" }, -- tmux & split window navigation
	{ "szw/vim-maximizer", event = "VeryLazy" }, -- maximize split
	{ "mbbill/undotree", event = "VeryLazy" }, -- undo tree
	{
		"windwp/nvim-autopairs", -- autopairs
		event = "InsertEnter",
		config = true,
	},
	{
		"echasnovski/mini.icons", -- icons
		version = false,
		config = function()
			require("mini.icons").setup()
		end,
	},
	{
		"echasnovski/mini.comment", -- comments
		version = false,
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.surround", -- change surroundings
		version = false,
		config = function()
			vim.keymap.set("n", "s", "<Nop>", { noremap = true, silent = true }) -- disable s
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.operators", -- replace with register
		version = false,
		config = function()
			require("mini.operators").setup()
		end,
	},
	{
		"echasnovski/mini.ai", -- better a/i text objects
		version = false,
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"echasnovski/mini.jump", -- better jump f/t
		version = false,
		config = function()
			require("mini.jump").setup({ delay = { highlight = 6 * (10 ^ 7) } })
		end,
	},
	{
		"folke/zen-mode.nvim", -- zen mode
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>z", "<CMD>ZenMode<CR>", { desc = "Zen mode" })
		end,
	},
}
