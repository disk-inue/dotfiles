-- LuaJIT言語検出のためのimport
local ft = require("Comment.ft")

require("Comment").setup({
  -- 行の間にスペースを入れる
  padding = true,

  -- コメント後にカーソルの位置を維持
  sticky = true,

  -- コメントの際に無視する行
  ignore = "^$", -- 空行をスキップ

  -- ノーマルモードでのトグルマッピング
  toggler = {
    line = "gcc", -- 行コメントのトグル
    block = "gbc", -- ブロックコメントのトグル
  },

  -- ノーマル・ビジュアルモードでのマッピング
  opleader = {
    line = "gc", -- 行コメント
    block = "gb", -- ブロックコメント
  },

  -- 追加マッピング
  extra = {
    above = "gcO", -- 上の行にコメント追加
    below = "gco", -- 下の行にコメント追加
    eol = "gcA", -- 行末にコメント追加
  },

  -- キーバインディング有効化
  mappings = {
    basic = true, -- 基本マッピング (gcc, gc[count]{motion} など)
    extra = true, -- 追加マッピング (gco, gcO, gcA)
    extended = true, -- 拡張マッピング
  },

  -- コメント前の処理（言語に応じたコメントスタイルの適用）
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

  -- コメント後の処理
  post_hook = nil,
})

-- 言語別のコメントスタイル設定
ft.set("lua", { "--%s", "--[[%s]]" }) -- Lua
ft.set("javascript", { "//%s", "/*%s*/" }) -- JavaScript
ft.set("typescript", { "//%s", "/*%s*/" }) -- TypeScript
ft.set("typescriptreact", { "//%s", "{/*%s*/}" }) -- TSX
ft.set("css", { "/*%s*/" }) -- CSS
ft.set("scss", { "//%s", "/*%s*/" }) -- SCSS
ft.set("html", { "<!--%s-->" }) -- HTML
ft.set("svelte", { "<!--%s-->", "{/*%s*/}" }) -- Svelte
ft.set("vue", { "<!--%s-->", "{/*%s*/}" }) -- Vue
ft.set("json", null) -- JSONはコメントをサポートしていないので無効化
