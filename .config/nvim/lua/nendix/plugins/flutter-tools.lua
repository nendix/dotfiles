return {
	"akinsho/flutter-tools.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required by flutter-tools
		"stevearc/dressing.nvim", -- Optional, for UI enhancements
	},
	ft = "dart",
	config = function()
		require("flutter-tools").setup({
			-- Enable FVM support
			fvm = true, -- This ensures Flutter Tools uses FVM

			-- Widget guides (helps with Flutter UI development)
			widget_guides = {
				enabled = true,
			},

			-- LSP configuration for Dart
			lsp = {
				settings = {
					showtodos = true, -- Highlight TODOs in the code
					completefunctioncalls = true, -- Auto-complete function calls
					analysisexcludedfolders = {
						vim.fn.expand("$HOME/.pub-cache"), -- Exclude the pub cache from analysis
					},
					renamefileswithclasses = "prompt", -- Prompt when renaming files with classes
					updateimportsonrename = true, -- Update imports when renaming files
					enablesnippets = false, -- Disable snippets (optional)
				},
			},

			-- Debugger configuration
			-- debugger = {
			-- 	enabled = true, -- Enable debugging
			-- 	run_via_dap = true, -- Use DAP (Debug Adapter Protocol) for debugging
			-- 	exception_breakpoints = {}, -- Configure exception breakpoints (optional)
			--
			-- 	-- Register DAP configurations
			-- 	register_configurations = function(paths)
			-- 		local dap = require("dap")
			-- 		-- Configure the Dart debug adapter
			-- 		dap.adapters.dart = {
			-- 			type = "executable",
			-- 			command = paths.flutter_bin, -- Use the Flutter binary resolved by FVM
			-- 			args = { "debug-adapter" },
			-- 		}
			-- 		dap.configurations.dart = {} -- Dart debug configurations
			-- 		require("dap.ext.vscode").load_launchjs() -- Load launch configurations from .vscode/launch.json
			-- 	end,
			-- },
		})
	end,
}
