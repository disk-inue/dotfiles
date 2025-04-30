local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

-- フォーマット用の関数
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- LSPベースのフォーマットを優先
      return client.name ~= "tsserver" -- tsserverは除外（他のフォーマッターを優先）
    end,
    bufnr = bufnr,
    timeout_ms = 5000, -- タイムアウトを5秒に設定
  })
end

-- 設定グループの作成
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- フォーマッターとリンター
local sources = {
  -- フォーマッター
  null_ls.builtins.formatting.prettier, -- 汎用フォーマッター

  -- Git統合
  null_ls.builtins.code_actions.gitsigns, -- Gitの変更に対するアクション
}

null_ls.setup({
  debug = false,
  sources = sources,
  on_attach = function(client, bufnr)
    -- フォーマット機能がある場合は自動フォーマット設定
    if client.supports_method("textDocument/formatting") then
      -- 保存時の自動フォーマット
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })

      -- フォーマットコマンドを追加
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
        lsp_formatting(bufnr)
      end, { desc = "Format current buffer" })
    end
  end,
})
