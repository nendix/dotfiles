return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "NvimTree" },
					winbar = {},
				},
			},
			sections = {
				lualine_a = {
					"mode",
					{
						require("noice").api.statusline.mode.get,
						cond = require("noice").api.statusline.mode.has,
					},
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },

				lualine_x = {
					"encoding",
					"filetype",
				},
				lualine_y = { "lsp_status" },
				lualine_z = { "location" },
			},
		})
	end,
}
