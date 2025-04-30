-- LspAttachイベントで必要最小限のバッファローカルなキーマップのみ設定
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- バッファローカルなオプションのみ保持
    local opts = { buffer = ev.buf }
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = buffer,
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

require("lspconfig").ltex.setup({
  settings = {
    ltex = {
      language = "ja",
      additionalRules = { enablePickyRules = true },
    },
  },
})
