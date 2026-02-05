vim.loader.enable()
require("options")
require("keybinds")
require("appearance")
require("extensions")

-- netrw
vim.api.nvim_set_var("loaded_netrw", 1)
vim.api.nvim_set_var("loaded_netrwPlugin", 1)

-- NOTE: 非推奨警告を抑制。バージョンアップ時は一時的にコメントアウトして確認推奨
vim.deprecate = function() end
