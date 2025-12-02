-- remove when telescope fixes the winborder bug
vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopeFindPre",
	callback = function()
		vim.opt_local.winborder = "none"
		vim.api.nvim_create_autocmd("WinLeave", {
			once = true,
			callback = function()
				vim.opt_local.winborder = "rounded"
			end,
		})
	end,
})

-- LineBlame of current line
vim.api.nvim_create_user_command("BlameLine", function()
	require("gitsigns").blame_line()
end, { desc = "Open current line blame in floating window" })
