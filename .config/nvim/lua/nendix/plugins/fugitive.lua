return {
	"tpope/vim-fugitive",
	event = "BufWinEnter",
	config = function()
		vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })

		vim.keymap.set("n", "<leader>gaa", "<cmd>Git add --all<CR>", { desc = "Git add all" })
		vim.keymap.set("n", "<leader>gaf", "<cmd>Gwrite<CR>", { desc = "Git add file" })
		vim.keymap.set("n", "<leader>gc", ":Git commit -m ", { desc = "Git commit" })
		vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git push" })

		vim.keymap.set("n", "<leader>gr", "<cmd>Git reset<CR>", { desc = "Git reset" })
		vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Git diff" })

		-- rebase always
		vim.keymap.set("n", "<leader>gP", "<cmd>Git pull --rebase<CR>", { desc = "Git pull" })

		-- NOTE: It allows me to easily set the branch i am pushing any
		-- tracking needed if i did not set the branch up correctly.
		vim.keymap.set("n", "<leader>gsb", ":Git push -u origin ", { desc = "Git push set branch" })
	end,
}
