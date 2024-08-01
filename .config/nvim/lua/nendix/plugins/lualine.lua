return {

	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = require("nendix.custom.themes.catline").theme(),
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
						color = { fg = "#181825" },
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
