return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true,
				show_end_of_buffer = false, -- show the '~' characters after the end of buffers
				term_colors = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = {
					comments = { "italic" },
					conditionals = {},
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
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
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"gmr458/cold.nvim",
		lazy = false,
		priority = 1000,
		build = ":ColdCompile",
		config = function()
			require("cold").setup({
				transparent_background = true,
				italic_keyword = true,
			})
			-- vim.cmd.colorscheme("cold")
		end,
	},
	{
		"mellow-theme/mellow.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.mellow_transparent = true
			vim.g.mellow_italic_functions = true
			-- vim.cmd.colorscheme("mellow")
		end,
	},
}
