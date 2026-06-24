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
	gh("nvim-mini/mini-git"),
	-- utils
	gh("lukas-reineke/indent-blankline.nvim"),
	gh("folke/which-key.nvim"),
	gh("nvim-lua/plenary.nvim"),
	{ src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
	gh("stevearc/conform.nvim"),
	gh("catgoose/nvim-colorizer.lua"),
	gh("windwp/nvim-autopairs"),
	gh("christoomey/vim-tmux-navigator"),
	gh("szw/vim-maximizer"),
	gh("rachartier/tiny-cmdline.nvim"),
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
	variant = "auto",
	transparent = true,
})
vim.cmd.colorscheme("zen")

-- mini statusline
local MiniStatusline = require("mini.statusline")

-- mode + macro recording indicator
local function section_mode(args)
	local mode, hl = MiniStatusline.section_mode(args)
	local rec = vim.fn.reg_recording()
	return mode .. (rec ~= "" and " @" .. rec or ""), hl
end

-- filename relative to CWD
local function section_filename(args)
	if vim.bo.buftype == "terminal" then
		return "%t"
	end
	local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
	if path == "" or MiniStatusline.is_truncated(args.trunc_width) then
		path = path == "" and "%f" or vim.fn.pathshorten(path)
	end
	return path .. "%m%r"
end

MiniStatusline.setup({
	content = {
		active = function()
			local mode, mode_hl = section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local filename = section_filename({ trunc_width = 140 })
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })
			local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
				"%<", -- Mark general truncate point
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=", -- End left alignment
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
				{ hl = mode_hl, strings = { search, location } },
			})
		end,
	},
})

-- mini icons
require("mini.icons").setup()

-- mini files
local MiniFiles = require("mini.files")
MiniFiles.setup()

-- mini picker
local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup({
	mappings = { mark_all = "<C-q>", choose_marked = "<C-CR>" },
})
MiniExtra.setup()

-- completions
local Blink = require("blink.cmp")
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

-- cmdline
require("tiny-cmdline").setup({
	on_reposition = require("tiny-cmdline").adapters.blink,
})

-- mini git
local MiniGit = require("mini.git")
MiniGit.setup()

-- mini diff
local MiniDiff = require("mini.diff")
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

-- indent-blankline
require("ibl").setup({
	indent = { char = "│" },
	scope = { enabled = false },
})

-- harpoon
require("harpoon"):setup()

-- preview
require("peek").setup({ app = "webview" })
require("typst-preview").setup()
