vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", vim.cmd.w, { desc = "Save file" }) --save
vim.keymap.set("n", "<leader>q", vim.cmd.q, { desc = "Quit file" }) -- quit

-- native undotree
vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlighting", silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves lines up in visual selection" })

vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" }
)

vim.keymap.set("n", "<leader>re", "<CMD>restart<CR>", { desc = "Restart config :restart)" })

-- diagnostics
vim.keymap.set("n", "<leader>xl", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "<leader>xf", vim.diagnostic.setloclist, { desc = "File diagnostics" })
vim.keymap.set("n", "<leader>xw", vim.diagnostic.setqflist, { desc = "Workspace diagnostics" })

-- lsp
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "Go to declatarion" })
vim.keymap.set("n", "grf", vim.lsp.buf.format, { desc = "Format file" })

-- quickfix list
vim.keymap.set("n", "<leader>co", "<CMD>cwindow<CR>", { desc = "Open qflist" })
vim.keymap.set("n", "<leader>cn", "<CMD>cnext<CR>", { desc = "Next item qflist" })
vim.keymap.set("n", "<leader>cp", "<CMD>cprev<CR>", { desc = "Previous item qflist" })

-- location list
vim.keymap.set("n", "<leader>lo", "<CMD>lwindow<CR>", { desc = "Open loclist" })
vim.keymap.set("n", "<leader>ln", "<CMD>lnext<CR>", { desc = "Next item loclist" })
vim.keymap.set("n", "<leader>lp", "<CMD>lprev<CR>", { desc = "Previous item loclist" })

-- increment/decrement
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment" })
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement" })

----------------------
-- PLUGIN KEYMAPS
----------------------

-- explorer
vim.keymap.set("n", "<leader>e", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
	MiniFiles.reveal_cwd()
end, { desc = "File explorer in cwd" })
vim.keymap.set("n", "<leader>E", "<CMD>lua MiniFiles.open()<CR>", { desc = "File explorer" })

-- picker
vim.keymap.set("n", "<leader><space>", function()
	MiniPick.builtin.buffers()
end, { desc = "Find open buffers" })
vim.keymap.set("n", "<leader>/", function()
	MiniExtra.pickers.buf_lines({ scope = "current" })
end, { desc = "Fuzzy search current buffer" })
vim.keymap.set("n", "<leader>ff", function()
	MiniPick.builtin.files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fr", function()
	MiniExtra.pickers.oldfiles()
end, { desc = "Find recent files" })
vim.keymap.set("n", "<leader>fs", function()
	MiniPick.builtin.grep_live()
end, { desc = "Find string in cwd" })
vim.keymap.set("n", "<leader>fw", function()
	MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
end, { desc = "Find word under cursor" })
vim.keymap.set("n", "<leader>fh", function()
	MiniPick.builtin.help()
end, { desc = "Find help" })
vim.keymap.set("n", "<leader>fk", function()
	MiniExtra.pickers.keymaps()
end, { desc = "Find keymaps" })
vim.keymap.set("n", "<leader>fx", function()
	MiniExtra.pickers.diagnostic()
end, { desc = "Find diagnostics" })

-- typst preview
vim.keymap.set("n", "<leader>tp", "<CMD>TypstPreviewToggle<CR>", { desc = "Toggle Typst Preview" })
vim.keymap.set("n", "<leader>ts", "<CMD>TypstPreviewSyncCursor<CR>", { desc = "Force Sync Cursor" })

-- git (mini.git)
vim.keymap.set("n", "<leader>gaa", "<CMD>Git add --all<CR>", { desc = "Git add all" })
vim.keymap.set("n", "<leader>gaf", "<CMD>Git add %<CR>", { desc = "Git add file" })
vim.keymap.set("n", "<leader>gc", "<CMD>Git commit<CR>", { desc = "Git commit" })
vim.keymap.set("n", "<leader>gp", "<CMD>Git push<CR>", { desc = "Git push" })
vim.keymap.set("n", "<leader>gr", "<CMD>Git reset<CR>", { desc = "Git reset" })
vim.keymap.set("n", "<leader>gd", function()
	MiniDiff.toggle_overlay()
end, { desc = "Git diff overlay" })
vim.keymap.set("n", "<leader>gl", "<CMD>Git pull --rebase<CR>", { desc = "Git pull" })

-- conform
vim.keymap.set({ "n", "v" }, "<leader>mf", function()
	require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
end, { desc = "Format file or range" })

-- vim-maximizer
vim.keymap.set("n", "<C-w>m", "<CMD>MaximizerToggle<CR>", { desc = "Toggle split window zoom" })

-- harpoon
vim.keymap.set("n", "<leader>hm", function()
	require("harpoon"):list():add()
end, { desc = "Harpoon mark file" })
vim.keymap.set("n", "<leader>hh", function()
	local h = require("harpoon")
	h.ui:toggle_quick_menu(h:list())
end, { desc = "Harpoon menu" })
vim.keymap.set("n", "<leader>hc", function()
	require("harpoon"):list():clear()
end, { desc = "Harpoon clear" })
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, function()
		require("harpoon"):list():select(i)
	end, { desc = "Harpoon file " .. i })
end

-- colorizer
vim.keymap.set("n", "<leader>ct", "<CMD>ColorizerToggle<CR>", { desc = "Toggle colorizer" })
