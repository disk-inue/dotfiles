local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  -- Neovim 0.11以降のfuzzy matchingを有効化
  matching = {
    disallow_fuzzy_matching = false,
    disallow_fullfuzzy_matching = false,
    disallow_partial_fuzzy_matching = false,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = false,
  },
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
    documentation = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      border = "rounded",
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
        preset = "codicons",
        symbol_map = { Copilot = "" },
      })(entry, vim_item)

      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "    (" .. (strings[2] or "") .. ")"

      -- 入力文字列の一部を切り取る（長すぎる場合）
      local label = vim_item.abbr
      local truncated_label = vim.fn.strcharpart(label, 0, 30)
      if truncated_label ~= label then
        vim_item.abbr = truncated_label .. "..."
      end

      return kind
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp",                priority = 1000 },
    { name = "nvim_lsp_signature_help", priority = 900 },
    { name = "luasnip",                 priority = 800 },
    { name = "copilot",                 priority = 700 },
    { name = "buffer",                  priority = 500 },
    { name = "path",                    priority = 300 },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      -- よりマッチ度の高い順に優先
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find("^_+")
        local _, entry2_under = entry2.completion_item.label:find("^_+")
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

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

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "path",    priority = 500 },
    { name = "cmdline", priority = 300 },
  },
  matching = { disallow_symbol_nonprefix_matching = false },
})
