-- Keep the current directory and the browsing directory synced.
vim.g.netrw_keepdir = 0

-- Kill the massive header banner completely
vim.g.netrw_banner = 0

-- Use a modern "Tree" style view by default
-- 0 = thin, 1 = long, 2 = wide, 3 = tree
vim.g.netrw_liststyle = 3

-- Keep Neovim's current working directory perfectly in sync with Netrw
vim.g.netrw_keepdir = 0

-- Tell Netrw to open files in a vertical split by default
-- 0 = same window, 1 = horizontal split, 2 = vertical split, 3 = new tab, 4 = previous window
vim.g.netrw_browse_split = 0

-- Force splits to open below and to the right (modern standard)
vim.g.netrw_altv = 1
vim.g.netrw_alto = 1

-- Hide hidden files/dotfiles by default
vim.g.netrw_list_hide = [[^\..*]]
vim.g.netrw_hide = 1 -- You can press 'gh' inside netrw to toggle hidden files

-- Set the width to 33% of the screen (for sidebar mode)
vim.g.netrw_winsize = 33

-- Copy recursively
vim.g.netrw_localcopydircmd = "cp -r"

-- ==========================================
-- Netrw Custom Keymaps
-- ==========================================
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		local bind = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true, desc = desc })
		end
		bind("H", "u", "Go back in history")
		bind("h", "-", "Go up a directory")
		bind("l", "<CR>", "Open directory/file")
		bind(".", "gh", "Toggle dotfiles")
		bind("a", "%:w<CR>:buffer #<CR>", "Create a real file")
		bind("r", "R", "Rename file")
		bind("c", "mc", "Copy marked files")
		bind("C", "mtmc", "Target and copy marked files")
		bind("x", "mm", "Move marked files")
		bind("X", "mtmm", "Target and move marked files")
		bind(";", "mx", "Run external command on marked")
		bind("<TAB>", "mf", "Toggles the mark on a file or directory.")
		bind("<S-TAB>", "mF", "Unmark all the files in the current buffer.")
		bind("<leader><TAB>", "mu", "Remove all the marks on all files.")
		bind("M", [[:echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>]], "Show marked files")
		bind("T", [[:echo 'Target: ' . netrw#Expose("netrwmftgt")<CR>]], "Show target directory")
		bind("t", "mtT", "Set target directory and show it")
	end,
})
-- Smart toggle for Netrw sidebar in CWD
vim.keymap.set("n", "<leader>e", function()
	local found_netrw = false

	-- Loop through all windows on the current screen
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local buf = vim.api.nvim_win_get_buf(win)

		-- If we find a window with Netrw open, close it
		if vim.api.nvim_get_option_value("filetype", { buf = buf }) == "netrw" then
			vim.api.nvim_win_close(win, true)
			found_netrw = true
			break
		end
	end

	-- If we didn't find one to close, open a fresh one in the CWD
	if not found_netrw then
		vim.cmd("Lexplore .")
	end
end, { desc = "Toggle Lex in CWD" })
