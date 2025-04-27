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
					DiagnosticError = { fg = "#ffa3a3" }, -- Bright red
					DiagnosticWarn = { fg = "#f7ca88" }, -- Orange
					DiagnosticInfo = { fg = "#739393" }, -- Light blue
					DiagnosticHint = { fg = "#c493b0" }, -- Purple

					DiagnosticUnderlineError = { undercurl = true, sp = "#ffa3a3" },
					DiagnosticUnderlineWarn = { undercurl = true, sp = "#f7ca88" },
					DiagnosticUnderlineInfo = { undercurl = true, sp = "#739393" },
					DiagnosticUnderlineHint = { undercurl = true, sp = "#c493b0" },

					DiagnosticVirtualTextError = { bg = "#ffa3a3" },
					DiagnosticVirtualTextWarn = { bg = "#f7ca88" },
					DiagnosticVirtualTextInfo = { bg = "#739393" },
					DiagnosticVirtualTextHint = { bg = "#c493b0" },

					GitSignsAdd = { fg = "#9ebc9f" },
					GitSignsChange = { fg = "#f7ca88" },
					GitSignsDelete = { fg = "#ffa3a3" },
				},
			})
			-- require("black-metal").load()
		end,
	},
	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup({
				transparent = true,
				style = {
					strings = "none",
				},
			})
			vim.cmd.colorscheme("vague")
		end,
	},
}
