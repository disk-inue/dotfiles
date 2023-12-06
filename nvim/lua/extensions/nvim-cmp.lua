local cmp = require("cmp")
local act = require("extensions.nvim-cmp-actions")
local luasnip = require("luasnip")

local map = cmp.mapping

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {},
  mapping = map.preset.insert({
    ["<C-b>"] = map.scroll_docs(-4),
    ["<C-f>"] = map.scroll_docs(4),
    ["<C-Space>"] = map.complete(),
    ["<C-e>"] = map.abort(),
    ["<CR>"] = map.confirm({ select = false }),
    ["<Tab>"] = map(act.tab, { "i", "s" }),
    ["<S-Tab>"] = map(act.shift_tab, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" },
  }, {
    { name = "copilot" },
  }, {
    { name = "buffer" },
  }, {
    { name = "path" },
  }),
  formatting = {
    format = require("lspkind").cmp_format({
      mode = "symbol", -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      preset = "codicons",
      symbol_map = { Copilot = "" },
    }),
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = "buffer" },
  }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "nvim_lsp_document_symbol" },
    {
      name = "buffer",
      option = {
        keyword_pattern = [[\k\+]],
      },
    },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
