local gh = function(x)
	return "https://github.com/" .. x
end
-- local cb = function(x) return 'https://codeberg.org/' .. x end

vim.pack.add({
	-- colorscheme
	gh("nendix/zen.nvim"),
	-- mini
	gh("nvim-mini/mini.statusline"),
	gh("nvim-mini/mini.icons"),
	gh("nvim-mini/mini.files"),
	gh("nvim-mini/mini.surround"),
	gh("nvim-mini/mini.ai"),
	gh("nvim-mini/mini.operators"),
	gh("nvim-mini/mini.pick"),
	gh("nvim-mini/mini.extra"),
	gh("nvim-mini/mini.diff"),
	gh("folke/which-key.nvim"),
	-- utils
	gh("nvim-lua/plenary.nvim"),
	{ src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
	gh("stevearc/conform.nvim"),
	gh("catgoose/nvim-colorizer.lua"),
	gh("windwp/nvim-autopairs"),
	gh("christoomey/vim-tmux-navigator"),
	gh("szw/vim-maximizer"),
	gh("nvim-mini/mini-git"),
	-- completion
	gh("saghen/blink.lib"),
	gh("saghen/blink.cmp"),
	gh("rafamadriz/friendly-snippets"),
	-- preview
	gh("toppair/peek.nvim"),
	{ src = gh("chomosuke/typst-preview.nvim"), version = vim.version.range("1.0.0 - 2.0.0") },
	-- treesitter
	gh("arborist-ts/arborist.nvim"),
	gh("windwp/nvim-ts-autotag"),
	-- lsp
	gh("mason-org/mason.nvim"),
	gh("neovim/nvim-lspconfig"),
	gh("antosha417/nvim-lsp-file-operations"),
})

-- colorscheme
require("zen").setup({
	transparent = true,
})

-- mini statusline
MiniStatusline = require("mini.statusline")
MiniStatusline.setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 75 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75, icon = "" })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local diag_str = diagnostics ~= "" and ("| " .. diagnostics) or ""
			local filename = vim.fn.expand("%:t") .. (vim.bo.modified and " [+]" or "")

			local macro = vim.fn.reg_recording()
			local macro_str = macro ~= "" and ("@" .. macro) or ""

			local progress = vim.ui.progress_status()

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode, macro_str } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diff } },
				"%<",
				{ hl = "MiniStatuslineFilename", strings = { "|", filename, diag_str } },
				"%=",
				{ hl = "MiniStatuslineFileinfo", strings = { progress, "%p%%" } },
				{ strings = { "%l:%c" } },
			})
		end,
	},
	use_icons = true,
})

-- mini icons
require("mini.icons").setup()

-- mini files
MiniFiles = require("mini.files")
MiniFiles.setup()

-- mini picker
MiniPick = require("mini.pick")
MiniExtra = require("mini.extra")
MiniPick.setup({
	mappings = { mark_all = "<C-q>", choose_marked = "<C-CR>" },
})
MiniExtra.setup()

-- completions
Blink = require("blink.cmp")
Blink.build():wait(60000)
Blink.setup({
	keymap = { preset = "super-tab" },
	completion = {
		documentation = { auto_show = false },
		trigger = { show_in_snippet = false },
	},
	cmdline = {
		keymap = { preset = "inherit" },
		completion = { menu = { auto_show = true }, ghost_text = { enabled = true } },
	},
	signature = { enabled = true },
})

-- mini git
MiniGit = require("mini.git")
MiniGit.setup()

-- mini diff
MiniDiff = require("mini.diff")
MiniDiff.setup({
	source = MiniDiff.gen_source.git({ index = false }), -- compare to HEAD
})

-- mini surround
require("mini.surround").setup()

-- mini a/i text objects
require("mini.ai").setup()

-- mini replace with register
require("mini.operators").setup({
	replace = {
		prefix = "cr",
	},
})

-- colorizer
require("colorizer").setup({
	user_default_options = { mode = "background" },
})

-- key clues
require("which-key").setup()

-- autopairs
require("nvim-autopairs").setup({ check_ts = true })

-- harpoon
require("harpoon"):setup()

-- preview
require("peek").setup({ app = "webview" })
require("typst-preview").setup()
