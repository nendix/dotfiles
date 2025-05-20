return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	-- use a release tag to download pre-built binaries
	version = "1.*",
	opts = {
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		keymap = {
			preset = "none",

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-c>"] = { "hide", "fallback" },

			["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<C-k>"] = { "select_prev", "fallback_to_mappings" },
			["<C-j>"] = { "select_next", "fallback_to_mappings" },

			["<C-p>"] = { "scroll_documentation_up", "fallback" },
			["<C-n>"] = { "scroll_documentation_down", "fallback" },

			["<C-v>"] = { "show_signature", "hide_signature", "fallback_to_mappings" },
		},
		cmdline = {
			keymap = { preset = "inherit" },
			completion = { menu = { auto_show = true }, ghost_text = { enabled = true } },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			menu = { border = "rounded" },
			documentation = { auto_show = false, window = { border = "rounded" } },
		},
		signature = { window = { border = "rounded" } },
	},
}
