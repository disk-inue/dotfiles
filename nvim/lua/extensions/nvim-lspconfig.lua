-- LSP関連のUIをカスタマイズ
local signs = {
  Error = " ", -- エラー: 赤い❌
  Warn = " ", -- 警告: オレンジの⚠️
  Hint = "󰌶 ", -- ヒント: 青い電球
  Info = " ", -- 情報: 青いℹ️
}

-- 診断マークの設定
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- 診断の表示オプション
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- 仮想テキストの前に表示するアイコン
    source = "if_many", -- 複数の診断元がある場合のみソースを表示
    severity = {
      min = vim.diagnostic.severity.HINT, -- すべての重要度を表示
    },
  },
  float = {
    source = true, -- フロートウィンドウにはソースを表示
    border = "rounded", -- 角丸ボーダー
    header = "", -- ヘッダーを表示しない
    prefix = "", -- プレフィックスは不要
  },
  signs = true, -- サイン列に診断マークを表示
  underline = true, -- 問題のある部分に下線を引く
  update_in_insert = false, -- インサート中は更新しない
  severity_sort = true, -- 重要度でソート
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
