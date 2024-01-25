return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "buffers",
			themable = true,
			number = "none",
			buffer_close_icon = "✕",
			close_command = "bdelete %d",
			close_icon = "",
			indicator = {
				style = "icon",
				icon = "▎", -- this should be omitted if indicator style is not 'icon'
			},
			left_trunc_marker = "",
			modified_icon = "●",
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					separator = true,
					highlight = "Directory",
				},
			},
			right_mouse_command = "bdelete! %d",
			right_trunc_marker = "",
			show_close_icon = true,
			show_tab_indicators = true,
			diagnostics = "nvim_lsp",
			separator_style = "thin",
		},
		highlights = {
			separator_selected = {
				fg = "#585b70",
			},
			separator_visible = {
				fg = "#585b70",
			},
			separator = {
				fg = "#585b70",
			},
			indicator_selected = {
				fg = "#74c7ec",
			},
		},
	},
}
