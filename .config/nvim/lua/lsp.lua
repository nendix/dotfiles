require("mason").setup()
require("lsp-file-operations").setup()

vim.diagnostic.config({ virtual_text = true })

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
	capabilities = capabilities,
	-- on_attach = function(_, bufnr)
	-- 	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	-- end,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

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

vim.lsp.enable({
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
})

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

-- formatting
require("conform").setup({
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
		typst = { "typstyle" },
	},
	formatters = {
		djlint = {
			args = { "--indent", "2", "--check", "-" },
			stdin = true,
		},
	},
	format_on_save = function(bufnr)
		if vim.tbl_contains({ "markdown" }, vim.bo[bufnr].filetype) then
			return
		end
		return { timeout_ms = 700, quiet = true, lsp_fallback = false }
	end,
})
