-- Clean up the native command-line window UI
vim.api.nvim_create_autocmd("CmdwinEnter", {
	group = vim.api.nvim_create_augroup("CleanCmdWin", { clear = true }),
	callback = function()
		-- Turn off distracting UI elements in the cedit split
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.cursorline = true -- Keep a highlight on the current command

		-- Optional: Map <Esc> to close the window instantly (natively you have to type :q or :cclose)
		vim.keymap.set("n", "<Esc>", "<CMD>quit<CR>", { buffer = true, silent = true })
	end,
})
