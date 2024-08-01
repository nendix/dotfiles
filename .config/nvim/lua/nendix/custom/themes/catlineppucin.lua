local catlineppucin = {}
catlineppucin.theme = function()
	local colors = {
		black = "#181826",
		white = "#ccd6f4",
		innerbg = nil,
		outerbg = "#313244",
		blue = "#89b4fa",
		green = "#a6e3a1",
		mauve = "#cba6f7",
		red = "#f38ba8",
		peach = "#fab387",
	}
	return {
		inactive = {
			a = { fg = colors.black, bg = colors.outerbg, gui = "bold" },
			b = { fg = colors.black, bg = colors.outerbg },
			c = { fg = colors.white, bg = colors.innerbg },
		},
		visual = {
			a = { fg = colors.black, bg = colors.mauve, gui = "bold" },
			b = { fg = colors.mauve, bg = colors.outerbg },
			c = { fg = colors.white, bg = colors.innerbg },
		},
		replace = {
			a = { fg = colors.black, bg = colors.red, gui = "bold" },
			b = { fg = colors.red, bg = colors.outerbg },
			c = { fg = colors.white, bg = colors.innerbg },
		},
		normal = {
			a = { fg = colors.black, bg = colors.blue, gui = "bold" },
			b = { fg = colors.blue, bg = colors.outerbg },
			c = { fg = colors.white, bg = colors.innerbg },
		},
		insert = {
			a = { fg = colors.black, bg = colors.green, gui = "bold" },
			b = { fg = colors.green, bg = colors.outerbg },
			c = { fg = colors.white, bg = colors.innerbg },
		},
		command = {
			a = { fg = colors.black, bg = colors.peach, gui = "bold" },
			b = { fg = colors.peach, bg = colors.outerbg },
			c = { fg = colors.white, bg = colors.innerbg },
		},
	}
end
return catlineppucin
