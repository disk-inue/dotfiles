require("gitsigns").setup({
  signs = {
    add = { text = " ▎" },
    change = { text = " ▎" },
    delete = { text = " " },
    topdelete = { text = " " },
    changedelete = { text = "▎ " },
    untracked = { text = " ▎" },
  },
  signs_staged = {
    add = { text = " ▎" },
    change = { text = " ▎" },
    delete = { text = " " },
    topdelete = { text = " " },
    changedelete = { text = "▎ " },
    untracked = { text = " ▎" },
  },
  signs_staged_enable = false,
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_forus = true,
  },
  current_line_blame_formatter = "<summary> (<author_time:%Y/%m>) - <author>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})
