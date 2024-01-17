vim.opt.termguicolors = true
local bufferline = require("bufferline")
bufferline.setup({
	options = {
		mode = "buffers",
		style_preset = bufferline.style_preset.default,
		themable = true,
		number = "none",
		buffer_close_icon = "",
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
		show_close_icon = false,
		show_tab_indicators = true,
		diagnostics = "nvim_lsp",
		separator_style = "thin",
	},
	highlights = {
		separator_selected = {
			fg = "#282c34",
		},
		separator_visible = {
			fg = "#282c34",
		},
		separator = {
			fg = "#282c34",
		},
		indicator_selected = {
			fg = "#61afef",
		},
	},
})
