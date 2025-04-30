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
				-- Override highlight groups
				highlights = {
					-- Diagnostic highlights
					DiagnosticError = { fg = "#6a4c4c" },
					DiagnosticWarn = { fg = "#8a7d4c" },
					DiagnosticInfo = { fg = "#4c5a75" },
					DiagnosticHint = { fg = "#6a4c6a" },

					DiagnosticUnderlineError = { undercurl = true, sp = "#6a4c4c" },
					DiagnosticUnderlineWarn = { undercurl = true, sp = "#8a7d4c" },
					DiagnosticUnderlineInfo = { undercurl = true, sp = "#4c5a75" },
					DiagnosticUnderlineHint = { undercurl = true, sp = "#6a4c6a" },

					DiagnosticVirtualTextError = { bg = "#6a4c4c" },
					DiagnosticVirtualTextWarn = { bg = "#8a7d4c" },
					DiagnosticVirtualTextInfo = { bg = "#4c5a75" },
					DiagnosticVirtualTextHint = { bg = "#6a4c6a" },

					GitSignsAdd = { fg = "#5a7a4c" },
					GitSignsChange = { fg = "#8a7d4c" },
					GitSignsDelete = { fg = "#6a4c4c" },

					DiffAdd = { fg = "#5a7a4c" },
					DiffChange = { fg = "#8a7d4c" },
					DiffDelete = { fg = "#6a4c4c" },
				},
			})
			-- require("black-metal").load()
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
			})
			require("neomodern").load()
		end,
	},
}
