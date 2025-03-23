return {
	"tpope/vim-fugitive",
	event = "BufWinEnter",
	config = function()
		vim.keymap.set("n", "<leader>gs", "<CMD>Git<CR>", { desc = "Git status" })

		vim.keymap.set("n", "<leader>gaa", "<CMD>Git add --all<CR>", { desc = "Git add all" })
		vim.keymap.set("n", "<leader>gaf", "<CMD>Gwrite<CR>", { desc = "Git add file" })
		vim.keymap.set("n", "<leader>gc", "<CMD>Git commit<CR>", { desc = "Git commit" })
		vim.keymap.set("n", "<leader>gC", ':Git commit -m "', { desc = "Git commit" })
		vim.keymap.set("n", "<leader>gp", "<CMD>Git push<CR>", { desc = "Git push" })

		vim.keymap.set("n", "<leader>gr", "<CMD>Git reset<CR>", { desc = "Git reset" })
		vim.keymap.set("n", "<leader>gfd", "<CMD>Gdiffsplit<CR>", { desc = "Git diff this file" })

		-- rebase always
		vim.keymap.set("n", "<leader>gP", "<CMD>Git pull --rebase<CR>", { desc = "Git pull" })
	end,
}
