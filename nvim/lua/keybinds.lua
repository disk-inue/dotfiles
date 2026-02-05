-- 基本的なキーマップはwhich-key.nvimで管理します
-- extensions/which-key.luaを参照してください

-- leader設定
vim.api.nvim_set_var("mapleader", ",")
vim.api.nvim_set_var("maplocalleader", "\\")

-- Normal to Command (コマンド入力をより使いやすく)
vim.keymap.set("n", ":", ";")
vim.keymap.set("n", ";", ":")

-- ペースト後にカーソルを移動しない
vim.keymap.set("v", "y", "y`]")
vim.keymap.set({ "v", "n" }, "p", "p`]")

-- 誤操作防止
vim.keymap.set("n", "ZZ", "<NOP>")
vim.keymap.set("n", "ZQ", "<NOP>")

-- レジスタを汚さないように
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("n", "s", '"_s')

-- ウィンドウ移動のショートカット (非leader系)
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- バッファ移動のショートカット (非leader系)
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")

-- スプリット (非leader系)
-- NOTE: 標準のJ(行結合)とL(画面下方移動)を上書きしている
vim.keymap.set("n", "<S-j>", ":split<CR>")
vim.keymap.set("n", "<S-l>", ":vsplit<CR>")

-- 行移動
vim.keymap.set({ "n", "v" }, "<C-n>", "20j")
vim.keymap.set({ "n", "v" }, "<C-p>", "20k")

-- 保存
vim.keymap.set("i", "jj", "<ESC>:<C-u>w<CR>")

-- 以下のキーマップはwhich-key.nvimで管理されています：
-- ファイル操作: <leader>f*
-- バッファ操作: <leader>b*
-- ウィンドウ操作: <leader>w*
-- Git操作: <leader>g*
-- LSP関連: <leader>l*
-- コード編集: <leader>c*
-- 検索/ナビゲーション: <leader>s*
-- Trouble: <leader>x*
-- テスト: <leader>t*

-- lspconfig診断用のキーマップは<leader>l*に移動済み
-- グローバルキーマップは残す
vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Show hover" })
vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, { desc = "Show references" })
vim.keymap.set("n", "<C-g>", function() vim.lsp.buf.signature_help() end, { desc = "Show signature help" })

-- Comment.nvimは<leader>c*に移行済み
-- デフォルトのgcc, gbcなどのマッピングは残す

-- Troubleは<leader>x*に移行済み

-- その他のプラグインのキーマップも<leader>キーで始まるものは全てwhich-keyに移行済み
-- <leader>を使わないデフォルトマッピングは各プラグインのデフォルト設定を使用
-- 例:
-- surround: add = ys{motion}{char}, delete = ds{char}, change = cs{target}{replacement}
-- nvim-ts-autotag: ciwtag
