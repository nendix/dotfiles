return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				css = { "prettier" },
				htmldjango = { "djlint" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				bash = { "shfmt" },
				shell = { "shfmt" },
				go = { "gofumpt" },
				c = { "clang-format" },
				java = { "clang-format" },
				python = { "black" },
				dart = { "dartfmt" },
				typst = { "typstyle" },
			},
			formatters = {
				dartfmt = {
					command = "dart", -- Replace with your formatter command
					args = { "format" }, -- Replace with your formatter args
					stdin = true, -- Whether to pass the file content via stdin
				},
				-- Configure djlint
				djlint = {
					args = { "--indent", "2", "--check", "-" }, -- Use "-" for stdin
					stdin = true, -- Pass file content via stdin
				},
			},
			format_on_save = function(bufnr)
				local ignore_filetypes = { "markdown" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end
				return { timeout_ms = 700, quiet = true, lsp_fallback = false }
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
