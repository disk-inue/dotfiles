-- LuaSnipの設定
local luasnip = require("luasnip")
local types = require("luasnip.util.types")

-- スニペット設定
luasnip.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "DiagnosticWarn" } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "●", "DiagnosticInfo" } },
      },
    },
  },
})

-- スニペットの読み込み (friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

-- カスタムスニペットの読み込み
require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

-- スニペット間のジャンプにTabとShift-Tabを使用
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if luasnip.expandable() then
    luasnip.expand()
  elseif luasnip.jumpable(1) then
    luasnip.jump(1)
  else
    return "<Tab>"
  end
end, { expr = true, silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    return "<S-Tab>"
  end
end, { expr = true, silent = true })
