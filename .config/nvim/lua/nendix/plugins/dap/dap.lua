return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")

			require("nvim-dap-virtual-text").setup({})

			-- custom breakpoint
			local sign = vim.fn.sign_define
			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
			sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoin" })
			vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "Run to cursor" })
			-- Eval var under cursor
			vim.keymap.set("n", "<leader>d?", function()
				require("dapui").eval(nil, { enter = true })
			end, { desc = "Evaluate variable" })
			vim.keymap.set("n", "<F1>", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Step out" })
			vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Step back" })
			vim.keymap.set("n", "<F11>", dap.terminate, { desc = "Terminate" })
			vim.keymap.set("n", "<F12>", dap.restart, { desc = "Restart" })

			-- go dap config handled by plugin
			require("dap-go").setup()

			-- dap.adapters.codelldb = {
			-- 	type = "server",
			-- 	port = "13000",
			-- 	executable = {
			-- 		command = "~/.local/share/nvim/mason/bin/codelldb",
			-- 		args = { "--port", "13000" },
			-- 	},
			-- }
			-- dap.configurations.c = {
			-- 	{
			-- 		name = "Launch file",
			-- 		type = "codelldb",
			-- 		request = "launch",
			-- 		program = function()
			-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			-- 		end,
			-- 		cwd = "${workspaceFolder}",
			-- 		stopOnEntry = false,
			-- 	},
			-- }
		end,
	},
}
