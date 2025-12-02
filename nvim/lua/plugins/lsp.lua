local function setup_cmp()
	require("blink.cmp").setup({
		cmdline = { enabled = false },
		keymap = { preset = "enter" },
		completion = {
			keyword = { range = "full" },
			accept = { auto_brackets = { enabled = true } },
			menu = {
				auto_show = true,
			},
			documentation = { auto_show = true },
		},
		sources = {
			default = { "lsp", "path" },
		},
		signature = { enabled = true },
	})
end

local function setup_formatters()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			typescript = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			scss = { "prettierd" },
			typescriptreact = { "prettierd" },
			go = { "gofumpt" },
			markdown = { "prettierd" },
			rust = { "rustfmt" },
		},
	})

	-- Auto-format on save for supported filetypes
	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function(args)
			conform.format({
				bufnr = args.buf,
				lsp_fallback = true,
				timeout_ms = 3000,
			})
		end,
	})
end

-- local function setup_formatters()
-- 	require("conform").setup({
-- 		formatters_by_ft = {
-- 			lua = { "stylua" },
-- 			python = { "isort", "black" },
-- 			javascript = { "prettierd" },
-- 			json = { "prettierd" },
-- 			jsonc = { "prettierd" },
-- 			typescript = { "prettierd" },
-- 			html = { "prettierd" },
-- 			css = { "prettierd" },
-- 			scss = { "prettierd" },
-- 			typescriptreact = { "prettierd" },
-- 			go = { "gofumpt" },
-- 			markdown = { "prettierd" },
-- 			rust = { "rustfmt" },
-- 		},
-- 	})
-- end

local function setup_linters()
	require("lint").linters_by_ft = {
		typescript = { "eslint_d" },
		typescriptreact = { "eslint_d" },
		json = { "eslint_d" },
		go = { "golangcilint" },
	}
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
		callback = function()
			local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
			local client = get_clients({ bufnr = 0 })[1] or {}
			require("lint").try_lint(nil, { cwd = client.root_dir })
		end,
	})
end

local function ts_organize_imports(client)
	client:exec_cmd({
		title = "organize_imports",
		command = "_typescript.organizeImports",
		arguments = {
			vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
		},
	}, { bufnr = vim.api.nvim_get_current_buf() })
end

local function setup_lsps()
	local cmp = require("blink.cmp")
	vim.lsp.config("*", {
		capabilities = cmp.get_lsp_capabilities(),
	})
	vim.lsp.enable({
		"ts_ls",
		"lua_ls",
		"pyright",
		"json-lsp",
		"html-lsp",
		"clangd",
		"docker_compose",
		"dockerls",
		"gopls",
		"yamlls",
		"tailwindcss-language-server",
		"rust_analyzer",
	})
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
		{ "saghen/blink.cmp", version = "1.*" },
		"stevearc/conform.nvim",
		"mfussenegger/nvim-lint",
		"j-hui/fidget.nvim",
	},
	config = function()
		setup_lsps()
		require("mason").setup()
		setup_formatters()
		setup_linters()
		setup_cmp()
		require("fidget").setup()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function()
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<leader>d", ":lua vim.diagnostic.open_float()<CR>")
				vim.keymap.set("n", "<leader>c", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = true })
				vim.keymap.set("n", "<leader>f", function()
					require("conform").format({ lsp_fallback = true })
				end)
				vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
				vim.keymap.set("n", "<leader>e", "<cmd>Telescope diagnostics bufnr=0<cr>")
				-- Autocmd to sort imports for typescript
				local client = vim.lsp.get_clients({ name = "ts_ls", bufnr = 0 })[1]
				if client ~= nil then
					vim.api.nvim_create_user_command("OrganizeImports", function()
						ts_organize_imports(client)
					end, {})
					vim.keymap.set("n", "<leader>s", "<cmd>OrganizeImports<cr>")
				end
			end,
		})
		-- Diagnostics
		vim.diagnostic.config({
			update_in_insert = true,
			undercurl = true,
			virtual_text = true,
			float = {
				border = "rounded",
			},
		})
	end,
}
