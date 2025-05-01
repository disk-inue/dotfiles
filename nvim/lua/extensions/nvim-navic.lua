local colors = require("onenord.colors").load()

require("nvim-navic").setup({
  lsp = {
    auto_attach = true, -- LSPがアタッチされたときに自動的にアタッチする
    auto_attach_callback = nil, -- 自動アタッチ時に呼び出すコールバック関数
  },
  highlight = true, -- シンボルのハイライト
  depth_limit = 9, -- 最大表示深度
  depth_limit_indicator = "...", -- 深度制限を超えた場合に表示する文字列
  separator = " > ", -- ナビゲーション要素間のセパレータ
  safe_output = true, -- オーバーフローを防ぐか
  lazy_update_context = true, -- LSPリクエストを減らすためにコンテキストの更新を遅延させる
  click = false, -- クリックイベントを有効にする
  format_text = function(text)
    return text -- テキスト整形関数
  end,
  icons = {
    File = " ",
    Module = " ",
    Namespace = " ",
    Package = " ",
    Class = " ",
    Method = " ",
    Property = " ",
    Field = " ",
    Constructor = " ",
    Enum = " ",
    Interface = " ",
    Function = " ",
    Variable = " ",
    Constant = " ",
    String = " ",
    Number = " ",
    Boolean = " ",
    Array = " ",
    Object = " ",
    Key = " ",
    Null = " ",
    EnumMember = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },
})
