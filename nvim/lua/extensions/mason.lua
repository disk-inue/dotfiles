-- Mason自体の設定
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
    keymaps = {
      -- カスタムキーマップ
      toggle_package_expand = "<CR>",
      install_package = "i",
      update_package = "u",
      check_package_version = "c",
      update_all_packages = "U",
      check_outdated_packages = "C",
      uninstall_package = "X",
      cancel_installation = "<C-c>",
      apply_language_filter = "<C-f>",
    },
    border = "rounded",
    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
  },
  max_concurrent_installers = 4, -- 同時インストール数
  github = {
    download_url_template = "https://github.com/%s/releases/download/%s/%s",
  },
  log_level = vim.log.levels.INFO,
  pip = {
    install_args = {
      "--proxy", -- プロキシがある場合は設定
    },
  },
})

-- 基本機能のみ有効化
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",         -- TypeScript
    "eslint",        -- ESLint
    "html",          -- HTML
    "cssls",         -- CSS
    "jsonls",        -- JSON
    "yamlls",        -- YAML
    "stylelint_lsp", -- Stylelint (CSSリンター)
    "lua_ls",        -- Lua
    "bashls",        -- Bash
    "marksman",      -- Markdown
    "ltex",          -- テキスト校正
  },
})

-- LSPのケーパビリティを設定
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
capabilities.textDocument.colorProvider = { dynamicRegistration = false }
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

require("mason-null-ls").setup({
  ensure_installed = {
    "prettier", -- 各種フォーマット
    "gitsigns", -- Gitの統合機能
  },
  automatic_installation = true,
  automatic_setup = false, -- 手動で設定する
  handlers = {},
})
