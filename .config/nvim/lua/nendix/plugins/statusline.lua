return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		-- 1. Define the custom component without icons
		local function show_macro_recording()
			local recording_register = vim.fn.reg_recording()
			if recording_register == "" then
				return ""
			else
				return "@" .. recording_register
			end
		end

		-- 2. Autocommands to instantly refresh the statusline
		vim.api.nvim_create_autocmd("RecordingEnter", {
			callback = function()
				require("lualine").refresh({ place = { "statusline" } })
			end,
		})

		vim.api.nvim_create_autocmd("RecordingLeave", {
			callback = function()
				vim.defer_fn(function()
					require("lualine").refresh({ place = { "statusline" } })
				end, 50)
			end,
		})

		-- 3. Configure Lualine
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = { left = "", right = "" },
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
						show_macro_recording,
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
