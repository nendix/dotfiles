vim.api.nvim_create_autocmd("CmdwinEnter", {
	group = vim.api.nvim_create_augroup("CleanCmdWin", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.statuscolumn = ""
		vim.opt_local.cursorline = true
		vim.opt_local.spell = false
		vim.keymap.set("n", "<Esc>", "<CMD>quit<CR>", { buffer = true, silent = true })
		vim.keymap.set("n", "q", "<CMD>quit<CR>", { buffer = true, silent = true })
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	callback = function()
		if not vim.v.event.visual then
			vim.hl.on_yank({ higroup = "Visual" })
		end
	end,
})
