-- global - vim.optを使用(nvim_set_optionは非推奨)
vim.opt.termguicolors = true
vim.opt.scrolloff = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.clipboard = "unnamedplus"
vim.opt.spell = true
vim.opt.showmode = false
--[[ vim.opt.shortmess = "S" ]]
vim.g.loaded_perl_provider = 0

-- window - vim.wo.を使用(nvim_win_set_optionは非推奨)
vim.wo.number = true
-- vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.wo.signcolumn = "yes:1"
vim.wo.wrap = false
vim.wo.list = true
-- vim.wo.colorcolumn = '100'

-- buffer - vim.boを使用(nvim_buf_set_optionは非推奨)
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("buffer_set_options", {}),
  callback = function()
    vim.bo.swapfile = false
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 0
    vim.bo.expandtab = true
    vim.bo.spelllang = "en_us"
  end,
})
