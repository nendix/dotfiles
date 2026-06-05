return {
	{ "nvim-lua/plenary.nvim" }, -- lua functions that many plugins use
	{ "christoomey/vim-tmux-navigator", event = "VeryLazy" }, -- tmux & split window navigation
	{ "szw/vim-maximizer", event = "VeryLazy" }, -- maximize split
	{ "mbbill/undotree", event = "VeryLazy" }, -- undo tree
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")

			npairs.setup({ check_ts = true }) -- tree sitter

			npairs.add_rules({
				Rule("$", "$", { "tex", "latex", "typst" })
					:with_pair(cond.not_before_regex("\\", 1))
					:with_pair(cond.not_after_regex("$", 1)),
			})
			npairs.add_rules({
				Rule("<", ">", { "html", "javascriptreact", "typescriptreact", "vue", "xml" }):with_pair(
					cond.not_after_regex(">", 1)
				),
			})
		end,
	},
	{
		"echasnovski/mini.icons", -- icons
		version = false,
		config = true,
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
			require("mini.operators").setup({
				replace = {
					prefix = "cr",
				},
			})
		end,
	},
	{
		"echasnovski/mini.ai", -- better a/i text objects
		version = false,
		config = true,
	},
}
