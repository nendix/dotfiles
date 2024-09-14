return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>hm", "<CMD>lua require('harpoon.mark').add_file()<CR>", desc = "Mark file with harpoon" },
			{ "<leader>hc", "<CMD>lua require('harpoon.mark').clear_all()<CR>", desc = "Clear all harpoon marks" },
			{
				"<leader>hh",
				"<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>",
				desc = "Clear all harpoon marks",
			},

			{ "<leader>1", "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", desc = "Harpoon buffer 1" },
			{ "<leader>2", "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", desc = "Harpoon buffer 2" },
			{ "<leader>3", "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", desc = "Harpoon buffer 3" },
			{ "<leader>4", "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", desc = "Harpoon buffer 4" },
			{ "<leader>5", "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", desc = "Harpoon buffer 4" },
			{ "<leader>6", "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", desc = "Harpoon buffer 4" },
			{ "<leader>7", "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", desc = "Harpoon buffer 4" },
			{ "<leader>8", "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", desc = "Harpoon buffer 4" },
			{ "<leader>9", "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", desc = "Harpoon buffer 4" },
		},
	},
}
