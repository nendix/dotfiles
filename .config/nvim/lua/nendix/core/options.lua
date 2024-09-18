-- trigger treesitter for go files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.treesitter.start()
	end,
})

local opt = vim.opt -- for conciseness

opt.showmode = false
opt.swapfile = false

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.smartindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- removing cmdline
-- opt.cmdheight = 0
-- vim.api.nvim_create_autocmd({ "RecordingEnter" }, {
-- 	callback = function()
-- 		vim.opt.cmdheight = 1
-- 	end,
-- })
-- vim.api.nvim_create_autocmd({ "RecordingLeave" }, {
-- 	callback = function()
-- 		vim.opt.cmdheight = 0
-- 	end,
-- })
