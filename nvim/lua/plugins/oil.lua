return {
	"stevearc/oil.nvim",
	config = function()
		local oil = require("oil")
        oil.setup({
			view_options = {
				show_hidden = true,
			},
		})
		vim.keymap.set("n", "<leader>-", function()
			if vim.bo.filetype == "oil" then
				oil.close()
			else
				oil.open()
			end
		end)
	end,
}
