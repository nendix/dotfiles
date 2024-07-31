return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		require("ibl").setup({
			indent = {
				char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
			},
			scope = {
				enabled = false,
				show_start = false,
				show_end = false,
			},
		})
	end,
}
