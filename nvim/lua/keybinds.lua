-- vim.keymap.set('n','<Up>','<C-y>')
-- vim.keymap.set('n','<Down>','<C-e>')

-- Normal to Command
vim.keymap.set('n',':',';')
vim.keymap.set('n',';',':')

-- automatically joump to end of text you pasted
vim.keymap.set('v', 'y', 'y`]')
vim.keymap.set({ 'v', 'n' }, 'p', 'p`]')

vim.keymap.set('n','ZZ','<NOP>')
vim.keymap.set('n','ZQ','<NOP>')

-- do not overwrite default register
vim.keymap.set('n','x','"_x')
vim.keymap.set('n','X','"_X')
vim.keymap.set('n','s','"_s')

-- leader
vim.api.nvim_set_var('mapleader', '\\')
vim.api.nvim_set_var('maplocalleader', '_')

