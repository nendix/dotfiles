vim.ui.input = function(opts, on_confirm)
	opts = opts or {}
	-- Clean up the prompt string (remove trailing colon/spaces)
	local prompt = (opts.prompt or "Input"):gsub("[%s:]+$", "")
	local default = opts.default or ""

	-- 1. Create a temporary, unlisted scratch buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { default })

	-- 2. Calculate a dynamic width based on the prompt or default text
	local width = math.max(40, #default + 10, #prompt + 10)

	-- 3. Open a floating window right under your cursor
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "cursor",
		row = 1,
		col = 0,
		width = width,
		height = 1,
		style = "minimal",
		border = "rounded",
		title = " " .. prompt .. " ", -- Uses native Neovim 0.10+ window titles
		title_pos = "center",
	})

	-- 4. Start in Insert mode and put the cursor at the end of the default text
	vim.cmd("startinsert")
	vim.api.nvim_win_set_cursor(win, { 1, #default })

	-- Helper function to close everything cleanly
	local function close()
		vim.cmd("stopinsert")
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
		if vim.api.nvim_buf_is_valid(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end

	-- 5. Map <CR> to confirm and pass the text back to the LSP
	vim.keymap.set({ "n", "i" }, "<CR>", function()
		local lines = vim.api.nvim_buf_get_lines(buf, 0, 1, false)
		close()
		on_confirm(lines[1])
	end, { buffer = buf, silent = true })

	-- 6. Map <Esc> and <C-c> to cancel the operation
	local cancel = function()
		close()
		on_confirm(nil) -- Passing nil tells the LSP we aborted
	end
	vim.keymap.set({ "n", "i" }, "<Esc>", cancel, { buffer = buf, silent = true })
	vim.keymap.set({ "n", "i" }, "<C-c>", cancel, { buffer = buf, silent = true })
end
