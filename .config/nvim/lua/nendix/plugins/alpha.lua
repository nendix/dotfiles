return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = {
		"echasnovski/mini.icons",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Fallback icons in case mini.icons isn't available
		local icons = {
			file = " ",
			folder = " ",
			search = " ",
			text = " ",
			history = " ",
			gear = " ",
			exit = " ",
		}

		icons = {
			file = icons.file,
			folder = icons.folder,
			search = icons.search,
			text = icons.text,
			history = icons.history,
			gear = icons.gear,
			exit = icons.exit,
		}

		-- Set header
		dashboard.section.header.val = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
		}

		-- Set menu with proper icons
		dashboard.section.buttons.val = {
			dashboard.button("e", icons.file .. " New File", "<CMD>ene<CR>"),
			dashboard.button("SPC e", icons.folder .. " File Explorer", "<CMD>Oil --float<CR>"),
			dashboard.button("SPC ff", icons.search .. " Find File", "<CMD>Telescope find_files<CR>"),
			dashboard.button("SPC fg", icons.text .. " Live Grep", "<CMD>Telescope live_grep<CR>"),
			dashboard.button("c", icons.gear .. " Config", "<CMD>e ~/.config/nvim/<CR>"),
			dashboard.button("q", icons.exit .. " Quit", "<CMD>qa<CR>"),
		}

		-- Footer function
		local function footer()
			local version = vim.version()
			local vim_version = string.format("v%d.%d.%d", version.major, version.minor, version.patch)

			local quotes = {
				"Stay productive!",
				"Happy coding!",
				"Keep it simple.",
				"Code is poetry.",
			}

			return {
				"",
				"Neovim " .. vim_version,
				quotes[math.random(#quotes)],
			}
		end

		dashboard.section.footer.val = footer()

		-- Setup alpha
		alpha.setup(dashboard.opts)
	end,
}
