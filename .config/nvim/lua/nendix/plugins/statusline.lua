return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = { left = "", right = "" },
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
					},
				},
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename", "diagnostics" },

				lualine_x = {},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
