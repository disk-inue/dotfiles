-- mainブランチではsetup()はinstall_dirのみ受け付ける
-- パーサー管理はlazy.nvimのbuild = ":TSUpdate"と:TSInstallコマンドで行う
require("nvim-treesitter").setup()

-- 必要なパーサーをインストール（既にインストール済みの場合はスキップ）
-- tree-sitter-cli (>= 0.26.1) が必要: cargo install tree-sitter-cli
if vim.fn.executable("tree-sitter") == 1 then
  require("nvim-treesitter").install({
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
  })
end

-- highlight, indent はNeovim 0.12でコア機能として有効化
-- バッファ読み込み時にtreesitterを開始（パーサーがない場合やファイルが大きい場合はスキップ）
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_start", {}),
  callback = function(ev)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end
    -- パーサーが利用可能な場合のみ開始（非互換パーサーによるフリーズを防止）
    local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
    if pcall(vim.treesitter.language.add, lang) then
      pcall(vim.treesitter.start, ev.buf)
    end
  end,
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
