vim.g.netrw_banner = 0

vim.opt.showmode = false
vim.opt.exrc = true

vim.opt.relativenumber = true -- show relative line numbers
vim.opt.number = true -- shows absolute line number on cursor line (when relative number is on)

vim.opt.tabstop = 2 -- 2 spaces for tabs
vim.opt.softtabstop = 2 -- 2 spaces for tabs
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces

vim.opt.wrap = false
vim.opt.smartindent = true -- copy indent from current line when starting new one
vim.opt.inccommand = "split"

vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

vim.o.winborder = "single"
vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift

vim.opt.cursorline = true -- highlight the current cursor line
vim.opt.scrolloff = 8

vim.o.cmdheight = 0

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.foldenable = false -- Disable folding by default when opening a file

vim.opt.foldlevel = 99 -- Set a high foldlevel so most things stay open
