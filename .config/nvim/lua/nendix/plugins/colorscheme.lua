return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = true,
				term_colors = true,
				styles = {
					comments = { "italic" },
				},
				integrations = {
					alpha = true,
					blink_cmp = true,
					dap = true,
					dap_ui = true,
					gitsigns = true,
					harpoon = true,
					indent_blankline = { enabled = true, scope_color = "text", colored_indent_levels = false },
					lsp_trouble = true,
					markdown = true,
					mason = true,
					mini = { enabled = true, indentscope_color = "" },
					noice = true,
					notify = true,
					nvimtree = true,
					telescope = { enabled = true, style = "classic" },
					treesitter = true,
					which_key = true,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"aktersnurra/no-clown-fiesta.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("no-clown-fiesta").setup({
				transparent = true,
				styles = {
					-- You can set any of the style values specified for `:h nvim_set_hl`
					comments = { italic = true },
					functions = {},
					keywords = {},
					lsp = {},
					match_paren = {},
					type = {},
					variables = {},
				},
			})
			-- vim.cmd.colorscheme("no-clown-fiesta")
		end,
	},
	{
		"metalelf0/black-metal-theme-neovim",
		lazy = false,
		priority = 1000,
		config = function()
			require("black-metal").setup({
				-- theme can be one of: bathory, burzum, dark-funeral, darkthrone, emperor,
				-- gorgoroth, immortal, impaled-nazarene, khold, marduk, mayhem, nile, taake, venom.
				theme = "gorgoroth",
				plain_float = true,
				transparent = true,
				alt_bg = true,
				favor_treesitter_hl = true,
				code_style = {
					comments = "italic",
					conditionals = "none",
					functions = "none",
					keywords = "italic",
					headings = "bold", -- Markdown headings
					operators = "none",
					keyword_return = "none",
					strings = "none",
					variables = "none",
				},
			})
			-- vim.cmd.colorscheme("gorgoroth")
		end,
	},
	{
		"cdmill/neomodern.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("neomodern").setup({
				theme = "hojicha",
				plain_float = true,
				transparent = true,
				favor_treesitter_hl = true,
				code_style = {
					comments = "italic",
					conditionals = "none",
					functions = "none",
					keywords = "italic",
					headings = "bold", -- Markdown headings
					operators = "none",
					keyword_return = "none",
					strings = "none",
					variables = "none",
				},
				highlights = {
					IblIndent = { fg = "#333333", fmt = "nocombine" },
				},
			})
			vim.cmd.colorscheme("hojicha")
		end,
	},
}
