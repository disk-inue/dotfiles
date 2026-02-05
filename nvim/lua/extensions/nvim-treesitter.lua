require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "comment",
    "css",
    "csv",
    "dockerfile",
    "go",
    "graphql",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "mermaid",
    "prisma",
    "python",
    "regex",
    "ruby",
    "rust",
    "sql",
    "ssh_config",
    "terraform",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "gni", -- 0.11デフォルトのgrnと被らないように変更
      scope_incremental = "gns",
      node_decremental = "gnm",
    },
  },
  indent = {
    enable = true,
  },
})

-- ts_context_commentstringの設定
require('ts_context_commentstring').setup {
  enable_autocmd = false,
  languages = {
    typescript = '// %s',
    css = '/* %s */',
    scss = '// %s',
    php = '// %s',
    html = '<!-- %s -->',
    svelte = '<!-- %s -->',
    vue = '<!-- %s -->',
    handlebars = '{{!-- %s --}}',
  },
}
