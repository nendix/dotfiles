return {
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		ft = { "markdown" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				app = "webview",
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{
		"chomosuke/typst-preview.nvim",
		event = { "VeryLazy" },
		ft = "typst",
		version = "1.*",
		opts = {},
	},
}
