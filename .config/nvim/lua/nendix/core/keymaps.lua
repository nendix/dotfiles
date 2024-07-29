-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

keymap.set("n", "<leader>w", vim.cmd.w, { desc = "Save file(:w)" })
keymap.set("n", "<leader>q", vim.cmd.q, { desc = "Quit file(:q)" })
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "NvimTreeToggle" })
keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "UndotreeToggle" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "No highlights" })

keymap.set("x", "<leader>p", [["_dP]], { desc = "Copy and paste w/o copying into reg in visual mode" })

-- move lines
-- keymap.set("n", "<leader>j", ":m .+1<CR>==")
-- keymap.set("n", "<leader>k", ":m .-2<CR>==")
-- keymap.set("v", "<leader>j", ":m '>+1<CR>gv==gv")
-- keymap.set("v", "<leader>k", ":m '>-2<CR>gv==gv")

keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank w/o copying into system clipboard" })
keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line w/o copying into system clipboard" })

keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete w/o copying into reg" })

-- delete single character without ciw into register
-- keymap.set("n", "x", '"_x')

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split window" }) -- close current split window

--tab management
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" }) -- close current tab

----------------------
-- Plugin Keybinds
----------------------
-- buffer
keymap.set("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Split window maximization" }) -- toggle split window maximization

-- telescope
keymap.set("n", "<leader><space>", "<cmd>Telescope buffers<cr>", { desc = "Find open buffers" })
keymap.set(
	"n",
	"<leader>'",
	"<cmd>Telescope current_buffer_fuzzy_find theme=get_dropdown previewer=false<cr>",
	{ desc = "Fuzzily search in current buffer" }
)
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>fh", "<cmd>Telescope harpoon marks<cr>", { desc = "Find harpoon marks" })

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "List all git commits" }) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = "List git commits for current file/buffer" })
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "List git branches" })
keymap.set(
	"n",
	"<leader>gs",
	"<cmd>Telescope git_status<cr>",
	{ desc = "List current changes per file with diff preview " }
)

-- more mapping in lua/nendix/plugins/lsp/lspconfig.lua
