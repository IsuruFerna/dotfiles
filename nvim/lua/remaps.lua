-- Move code up/down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Center after search page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Buffers redirection to sys clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- buffer navigation
vim.keymap.set("n", "<A-c>", "<cmd>bd<cr>")
vim.keymap.set("n", "<A-l>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<A-h>", "<cmd>bprev<cr>")

-- Misc
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "q:", "<nop>", { noremap = true })

-- Disabled keymaps for wezterm usage
vim.keymap.set("n", "<C-f>", "<nop>", { noremap = true })
vim.keymap.set("n", "<C-t>", "<nop>", { noremap = true })

-- Duplicate lines
-- in normal mode
vim.keymap.set("n", "<A-Down>", "mzyyp`z", { silent = true })
vim.keymap.set("n", "<A-Up>", "mzyyP`z", { silent = true })
-- in visual mode
vim.keymap.set("v", "<A-Down>", "my'>p`y", { silent = true })
vim.keymap.set("v", "<A-Up>", "my'<P`y", { silent = true })
