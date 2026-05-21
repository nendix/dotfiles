require("vim._core.ui2").enable({
	msg = {
		target = "msg",
		targets = { emsg = "pager", echoerr = "pager", lua_error = "pager", rpc_error = "pager" },
	},
})

require("options")
require("keymaps")
require("commands")
require("autocmds")
require("plugins")
require("treesitter")
require("lsp")

vim.cmd.colorscheme("zen")
