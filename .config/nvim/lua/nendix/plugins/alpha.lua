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
			"                      :::!~!!!!!:.",
			"                  .xUHWH!! !!?M88WHX:.",
			"                .X*#M@$!!  !X!M$$$$$$WWx:.",
			"               :!!!!!!?H! :!$!$$$$$$$$$$8X:",
			"              !!~  ~:~!! :~!$!#$$$$$$$$$$8X:",
			"             :!~::!H!<   ~.U$X!?R$$$$$$$$MM!",
			"             ~!~!!!!~~ .:XW$$$U!!?$$$$$$RMM!",
			'               !:~~~ .:!M"T#$$$$WX??#MRRMMM!',
			'               ~?WuxiW*`   `"#$$$$8!!!!??!!!',
			'             :X- M$$$$       `"`T#$T~!8$WUXU~',
			"            :%`  ~#$$$m:        ~!~ ?$$$$$$",
			'          :!`.-   ~T$$$$8xx.  .xWW- ~""##*"',
			".....   -~~:<` !    ~?T#$$@@W@*?$$      /`",
			'W$@@M!!! .!~~ !!     .:XUW$W!~ `"~:    :',
			'#"~~`.:x%`!!  !H:   !WM$$$$Ti.: .!WUn+!`',
			':::~:!!`:X~ .: ?H.!u "$$$B$$$!W:U!T$$M~',
			'.~~   :X@!.-~   ?@WTWo("*$$$W$TH$! `',
			'Wi.~!X$?!-~    : ?$$$B$Wu("**$RM!',
			"$R@i.~~ !     :   ~$$$$$B$$en:`",
			'?MXT@Wx.~    :     ~"##*$$$$M~',
		}

		-- Set menu with proper icons
		dashboard.section.buttons.val = {
			dashboard.button("e", icons.file .. " New File", "<CMD>ene<CR>"),
			dashboard.button("SPC e", icons.folder .. " File Explorer", "<CMD>Oil --float<CR>"),
			dashboard.button("SPC ff", icons.search .. " Find File", "<CMD>Telescope find_files<CR>"),
			dashboard.button("SPC fs", icons.text .. " Live Grep", "<CMD>Telescope live_grep<CR>"),
			dashboard.button("c", icons.gear .. " Config", "<CMD>e ~/.config/nvim/<CR>"),
			dashboard.button("q", icons.exit .. " Quit", "<CMD>qa<CR>"),
		}

		-- Footer function
		local function footer()
			local version = vim.version()
			local vim_version = string.format("v%d.%d.%d", version.major, version.minor, version.patch)

			return {
				"Neovim " .. vim_version,
				-- quotes[math.random(#quotes)],
			}
		end

		dashboard.section.footer.val = footer()

		-- Setup alpha
		alpha.setup(dashboard.opts)
		-- Add additional padding after buttons (alternative approach)
		dashboard.config.layout = {
			{ type = "padding", val = 2 }, -- Padding before header
			dashboard.section.header,
			{ type = "padding", val = 4 }, -- Padding after header
			dashboard.section.buttons,
			{ type = "padding", val = 4 }, -- Padding before footer (spacer)
			dashboard.section.footer,
		}
	end,
}
