return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	keys = {
		vim.api.nvim_set_keymap("n", "grD", "<CMD>lua vim.lsp.buf.declaration()<CR>", { desc = "Go to declaration" }),
		vim.api.nvim_set_keymap("n", "grd", "<CMD>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" }),
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- 1. Global LSP Configuration
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- 2. Server-Specific Overrides
		vim.lsp.config("html", {
			filetypes = { "html", "htmldjango" },
		})

		vim.lsp.config("pylsp", {
			settings = {
				pylsp = {
					plugins = {
						pyflakes = { enabled = true },
						pylint = { enabled = false },
						mccabe = { enabled = false },
						pycodestyle = { enabled = false },
					},
				},
			},
		})

		vim.lsp.config("jdtls", {
			handlers = {
				["$/progress"] = function(_, _, _) end,
			},
		})

		-- 3. Enable the servers natively
		local servers = {
			"bashls",
			"clangd",
			"cssls",
			"gopls",
			"html",
			"jdtls",
			"lua_ls",
			"pylsp",
			"rust_analyzer",
			"tinymist",
			"zls",
		}

		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end

		-- 4. Configure diagnostics natively
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "󰠠",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
			underline = true,
			severity_sort = true,
		})
	end,
}
