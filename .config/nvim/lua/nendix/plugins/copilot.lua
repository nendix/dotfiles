return {
	"github/copilot.vim",
	event = "InsertEnter",
	config = function()
		vim.g.copilot_no_tab_map = true
		vim.g.copilot_assume_mapped = true

		-- Mappa Ctrl-E per accettare i suggerimenti di Copilot
		vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })
	end,
}
