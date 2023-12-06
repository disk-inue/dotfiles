-- require('hlslens').setup({
-- calm_down = true,
-- nearest_only = true,
-- nearest_float_when = 'never',
-- })

local config = {
  calm_down = true,
  nearest_only = true,
  nearest_float_when = "never",
}

vim.keymap.set({ "n", "x" }, "<Leader>L", function()
  vim.schedule(function()
    if require("hlslens").exportLastSearchToQuickfix() then
      vim.cmd("cw")
    end
  end)
  return ":noh<CR>"
end, { expr = true })

return config
