-- trigger treesitter for go files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.treesitter.start()
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.templ",
	command = "set filetype=go",
})
