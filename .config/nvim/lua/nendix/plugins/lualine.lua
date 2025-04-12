return {

	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("lualine").setup({
			options = {
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
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
						color = { fg = "#d8d8d8" },
					},
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_x = {
					"encoding",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
