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
MiniStatusline = require("mini.statusline")
MiniStatusline.setup()

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
