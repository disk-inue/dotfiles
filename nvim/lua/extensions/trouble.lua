local trouble = require 'trouble'

trouble.setup {
  use_diagnostic_signs = true,
}

vim.keymap.set('n', '<leader>xx', function() trouble.open() end)
vim.keymap.set('n', '<leader>xw', function() trouble.open 'workspace_diagnostics' end)
vim.keymap.set('n', '<leader>xd', function() trouble.open 'document_diagnostics' end)
vim.keymap.set('n', '<leader>xq', function() trouble.open 'quickfix' end)
vim.keymap.set('n', '<leader>xl', function() trouble.open 'loclist' end)

vim.keymap.set('n', 'gR', function() trouble.open 'lsp_references' end)
vim.keymap.set('n', 'gn', function() trouble.next { skip_groups = true, jump = true } end)
vim.keymap.set('n', 'gp', function() trouble.previous { skip_groups = true, jump = true } end)
vim.keymap.set('n', 'gF', function() trouble.first { skip_groups = true, jump = true } end)
vim.keymap.set('n', 'gL', function() trouble.last { skip_groups = true, jump = true } end)
