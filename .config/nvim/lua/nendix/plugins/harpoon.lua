return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>hm", function()
				harpoon:list():add()
			end, { desc = "Mark file with harpoon" })

			vim.keymap.set("n", "<leader>hh", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Toggle harpoon quick menu" })

			vim.keymap.set("n", "<leader>hc", function()
				harpoon:list():clear()
			end, { desc = "Clear all harpoon marks" })

			vim.keymap.set("n", "<leader>1", function()
				harpoon:list():select(1)
			end, { desc = "Harpoon file 1" })

			vim.keymap.set("n", "<leader>2", function()
				harpoon:list():select(2)
			end, { desc = "Harpoon file 2" })

			vim.keymap.set("n", "<leader>3", function()
				harpoon:list():select(3)
			end, { desc = "Harpoon file 3" })

			vim.keymap.set("n", "<leader>4", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon file 4" })

			vim.keymap.set("n", "<leader>5", function()
				harpoon:list():select(5)
			end, { desc = "Harpoon file 5" })

			vim.keymap.set("n", "<leader>6", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon file 6" })

			vim.keymap.set("n", "<leader>7", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon file 7" })

			vim.keymap.set("n", "<leader>8", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon file 8" })

			vim.keymap.set("n", "<leader>9", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon file 9" })

			vim.keymap.set("n", "<leader>0", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon file 10" })
		end,
	},
}
