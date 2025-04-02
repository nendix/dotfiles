return {
	"nvim-tree/nvim-web-devicons", -- vs-code icons
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	"szw/vim-maximizer", -- maximize split
	-- "inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
	"tpope/vim-surround", -- change surroundings
	{
		"mbbill/undotree",
		event = "VeryLazy",
	},
	"mg979/vim-visual-multi",
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
