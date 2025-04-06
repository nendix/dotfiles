return {
	-- { "nvim-tree/nvim-web-devicons" }, -- vs-code icons
	{ "nvim-lua/plenary.nvim" }, -- lua functions that many plugins use
	{ "christoomey/vim-tmux-navigator", event = "VeryLazy" }, -- tmux & split window navigation
	{ "szw/vim-maximizer", event = "VeryLazy" }, -- maximize split
	{ "mg979/vim-visual-multi", event = "VeryLazy" }, -- multiple cursors
	{ "mbbill/undotree", event = "VeryLazy" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"echasnovski/mini.icons",
		version = false,
		config = function()
			require("mini.icons").setup()
		end,
	},
	{
		"echasnovski/mini.comment",
		version = false,
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			vim.keymap.set("n", "s", "<Nop>", { noremap = true, silent = true }) -- disable s
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.operators",
		version = false,
		config = function()
			require("mini.operators").setup()
		end,
	},
	{
		"echasnovski/mini.ai",
		version = false,
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"echasnovski/mini.jump",
		version = false,
		config = function()
			require("mini.jump").setup({ delay = { highlight = 6 * (10 ^ 7) } })
		end,
	},
}
