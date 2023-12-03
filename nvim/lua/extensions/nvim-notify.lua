local notify = require 'notify'

notify.setup()

vim.notify = notify

local telescope = nil

vim.keymap.set('n', '<leader>fn', function()
  if telescope == nil then
    telescope = require 'telescope'
    telescope.load_extension 'notify'
  end

  telescope.extensions.notify.notify()
end)
