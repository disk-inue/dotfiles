-- vim.keymap.set('n','<Up>','<C-y>')
-- vim.keymap.set('n','<Down>','<C-e>')

-- Normal to Command
vim.keymap.set("n", ":", ";")
vim.keymap.set("n", ";", ":")

-- automatically joump to end of text you pasted
vim.keymap.set("v", "y", "y`]")
vim.keymap.set({ "v", "n" }, "p", "p`]")

vim.keymap.set("n", "ZZ", "<NOP>")
vim.keymap.set("n", "ZQ", "<NOP>")

-- do not overwrite default register
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("n", "s", '"_s')

-- leader
vim.api.nvim_set_var("mapleader", ",")
vim.api.nvim_set_var("maplocalleader", "\\")

-- window
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- buffer
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")

-- split
vim.keymap.set("n", "<S-j>", ":split<CR>")
vim.keymap.set("n", "<S-l>", ":vsplit<CR>")

-- move line
vim.keymap.set({ "n", "v" }, "<C-n>", "20j")
vim.keymap.set({ "n", "v" }, "<C-p>", "20k")

-- save
vim.keymap.set("i", "jj", "<ESC>:<C-u>w<CR>")
