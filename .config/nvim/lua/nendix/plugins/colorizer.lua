return {
	"catgoose/nvim-colorizer.lua",
	event = "VeryLazy",
	opts = { -- set to setup table
		filetypes = { "*" },
		user_default_options = {
			names = false, -- highlight names
			names_opts = { -- options for mutating/filtering names.
				lowercase = true, -- name:lower(), highlight `blue` and `red`
				camelcase = true, -- name, highlight `Blue` and `Red`
				uppercase = true, -- name:upper(), highlight `BLUE` and `RED`
				strip_digits = false, -- ignore names with digits,
				-- highlight `blue` and `red`, but not `blue3` and `red4`
			},
			-- Expects a table of color name to #RRGGBB value pairs.  # is optional
			-- Example: { cool = "#107dac", ["notcool"] = "ee9240" }
			-- Set to false|nil to disable, for example when setting filetype options
			names_custom = false, -- Custom names to be highlighted: table|function|false|nil
			RGB = true, -- #RGB hex codes
			RGBA = true, -- #RGBA hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = true, -- 0xAARRGGBB hex codes
			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			css = true, -- Enable all CSS *features*:
			-- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
			css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			-- Highlighting mode.  'background'|'foreground'|'virtualtext'
			mode = "virtualtext", -- Set the display mode
			-- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True is same as normal
			tailwind = "both", -- Enable tailwind colors
			-- parsers can contain values used in |user_default_options|
			sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
			-- Virtualtext character to use
			virtualtext = "■",
			-- Display virtualtext inline with color
			virtualtext_inline = true,
			-- Virtualtext highlight mode: 'background'|'foreground'
			virtualtext_mode = "foreground",
		},
	},
}
