return {
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
			{ "<leader>hc", "<cmd>lua require('harpoon.mark').clear_all()<cr>", desc = "Clear all harpoon marks" },
			{
				"<leader>hh",
				"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
				desc = "Clear all harpoon marks",
			},

			{ "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Harpoon buffer 1" },
			{ "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Harpoon buffer 2" },
			{ "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Harpoon buffer 3" },
			{ "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon buffer 4" },
			{ "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon buffer 4" },
			{ "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon buffer 4" },
			{ "<leader>7", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon buffer 4" },
			{ "<leader>8", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon buffer 4" },
			{ "<leader>9", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon buffer 4" },
		},
	},
}
