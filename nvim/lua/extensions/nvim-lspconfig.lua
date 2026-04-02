-- 診断の表示オプション（v0.12: sign_define廃止 → signs.textで設定）
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
  },
  float = {
    source = true,
    border = "rounded",
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Neovim 0.11以降では、フローティングウィンドウのボーダーはwinborderオプションで設定
-- グローバルハンドラーのオーバーライドは動作しなくなったため、winborderで統一的に設定
vim.o.winborder = "rounded"

-- LSPが有効になったときの設定
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- バッファローカルなキーマップ設定（主なものはwhich-keyで定義済み）
    -- ビジュアルモード範囲選択フォーマットは便利なのでローカルに追加
    if client and type(client.supports_method) == "function" and client.supports_method("textDocument/formatting") then
      vim.keymap.set("v", "<M-f>", function()
        local start_row, start_col = table.unpack(vim.api.nvim_buf_get_mark(0, "<"))
        local end_row, end_col = table.unpack(vim.api.nvim_buf_get_mark(0, ">"))
        vim.lsp.buf.format({
          async = true,
          range = {
            start = { line = start_row - 1, character = start_col },
            ["end"] = { line = end_row - 1, character = end_col },
          },
        })
      end, { buffer = bufnr, desc = "Format Selection" })
    end

    -- 便利なインライン診断表示トグル機能を追加
    vim.keymap.set("n", "<leader>lt", function()
      local new_value = not vim.diagnostic.config().virtual_text
      vim.diagnostic.config({ virtual_text = new_value })
      print("Inline diagnostics " .. (new_value and "enabled" or "disabled"))
    end, { buffer = bufnr, desc = "Toggle Inline Diagnostics" })

    -- カーソル下のシンボル情報をドキュメントに表示
    local has_document_symbol = client
      and client.server_capabilities
      and client.server_capabilities.documentSymbolProvider
    if has_document_symbol then
      require("nvim-navic").attach(client, bufnr)
    end
  end,
})

-- サーバー設定をmason-lspconfigのhandlersに移動
-- 個別の設定は全て削除
