return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
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
				dart = { "ast_grep" },
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
