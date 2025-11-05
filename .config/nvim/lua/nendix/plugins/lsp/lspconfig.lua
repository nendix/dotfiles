return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		-- import blink plugin
		local blink = require("blink.cmp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<CMD>Telescope lsp_references<CR>", opts) -- show references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<CMD>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<CMD>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Refactor"
			keymap.set("n", "<leader>rf", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>xd", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1 })
			end, opts)

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1 })
			end, opts)

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = blink.get_lsp_capabilities()

		-- configure diagnostics
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "", -- Error icon
					[vim.diagnostic.severity.WARN] = "", -- Warning icon
					[vim.diagnostic.severity.HINT] = "󰠠", -- Hint icon
					[vim.diagnostic.severity.INFO] = "", -- Info icon
				},
			},
			underline = true, -- Keep underlines for diagnostics
			severity_sort = true, -- Sort diagnostics by severity (errors first)
		})

		-- configure bash server
		vim.lsp.config("bashls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure typst server
		vim.lsp.config("tinymist", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure lua server
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure html server
		vim.lsp.config("html", {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "htmldjango" },
		})

		-- configure css server
		vim.lsp.config("cssls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure ts/js server
		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure c server
		vim.lsp.config("clangd", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure go server
		vim.lsp.config("gopls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure python server
		vim.lsp.config("pylsp", {
			capabilities = capabilities,
			on_attach = on_attach,
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

		-- configure rust server
		vim.lsp.config("rust_analyzer", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure java server
		vim.lsp.config("jdtls", {
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = {
				["$/progress"] = function(_, result, ctx) end,
			},
		})
	end,
}
