-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Statusline config
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#1C2225" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#1C2225" })
vim.api.nvim_set_hl(0, "StatusLineFilename", { fg = "#F8F9E8", bold = true })
vim.api.nvim_set_hl(0, "StatusLineRight", { fg = "#F8F9E8" })
vim.opt.statusline = "%#StatusLineFilename#%t%=%#StatusLineRight#%{expand('%:e')} %l/%L:%c"
