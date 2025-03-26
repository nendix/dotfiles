-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

keymap.set("n", "<leader>w", vim.cmd.w, { desc = "Save file" })
keymap.set("n", "<leader>q", vim.cmd.q, { desc = "Quit file" })
keymap.set("n", "<leader>u", "<CMD>UndotreeToggle<CR>", { desc = "Undotree" })
keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- quickfix list
keymap.set("n", "<leader>co", "<CMD>copen<CR>", { desc = "Open qflist" })
keymap.set("n", "<leader>cx", "<CMD>cclose<CR>", { desc = "Close qflist" })
keymap.set("n", "<leader>cn", "<CMD>cnext<CR>", { desc = "Next item qflist" })
keymap.set("n", "<leader>cp", "<CMD>cprev<CR>", { desc = "Previous item qflist" })

keymap.set("n", "<leader>nh", "<CMD>nohl<CR>", { desc = "No highlights" })

-- increment/decrement
keymap.set("n", "+", "<C-a>", { desc = "Increment" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<CMD>close<CR>", { desc = "Close current split window" }) -- close current split window

--tab management
keymap.set("n", "<leader>to", "<CMD>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<CMD>tabclose<CR>", { desc = "Close current tab" }) -- close current tab

----------------------
-- Plugin Keybinds
----------------------
-- buffer
keymap.set("n", "<leader>bx", "<CMD>bdelete<CR>", { desc = "Close buffer" })

-- vim-maximizer
keymap.set("n", "<leader>sm", "<CMD>MaximizerToggle<CR>", { desc = "Split window maximization" }) -- toggle split window maximization

-- telescope
keymap.set(
	"n",
	"<leader><space>",
	"<CMD>Telescope buffers theme=get_dropdown previewer=false<CR>",
	{ desc = "Find open buffers" }
)
keymap.set(
	"n",
	"<leader>'",
	"<CMD>Telescope current_buffer_fuzzy_find theme=get_dropdown previewer=false<CR>",
	{ desc = "Fuzzily search in current buffer" }
)
keymap.set(
	"n",
	"<leader>ff",
	"<CMD>Telescope find_files theme=ivy hidden=true no_ignore=true<CR>",
	{ desc = "Fuzzy find files in cwd" }
)
keymap.set(
	"n",
	"<leader>fr",
	"<CMD>Telescope oldfiles hidden=true no_ignore=true<CR>",
	{ desc = "Fuzzy find recent files" }
)
keymap.set("n", "<leader>fs", "<CMD>Telescope live_grep<CR>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<CMD>Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>fh", "<CMD>Telescope help_tags<CR>", { desc = "Find harpoon marks" })
keymap.set("n", "<leader>fj", "<CMD>Telescope jumplist<CR>", { desc = "Find jumps" })

-- telescope git commands
keymap.set("n", "<leader>gC", "<CMD>Telescope git_commits<CR>", { desc = "List all git commits" }) -- list all git commits (use <CR> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<CMD>Telescope git_bcommits<CR>", { desc = "List git commits for current file/buffer" })
keymap.set("n", "<leader>gb", "<CMD>Telescope git_branches<CR>", { desc = "List git branches" })
keymap.set("n", "<leader>gd", "<cmd>Telescope git_status<cr>", { desc = "List files with diffs" })

-- colorizer
keymap.set("n", "<leader>cc", "<CMD>ColorizerToggle<CR>", { desc = "Toggle colorizer" })

-- more mappings in:
-- lua/nendix/plugins/lsp/lspconfig.lua
-- lua/nendix/plugins/lsp/formatting.lua
-- lua/nendix/plugins/lsp/linting.lua
-- lua/nendix/plugins/harpoon.lua
-- lua/nendix/plugins/git-signs.lua
-- lua/nendix/plugins/trouble.lua
-- lua/nendix/plugins/nvim-cmp.lua
