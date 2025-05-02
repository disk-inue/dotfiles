require("which-key").setup({})

local wk = require("which-key")

-- 基本的なwhich-keyマッピング
local mappings = {
  -- ファイル操作 (拡張)
  { "<leader>f", group = "+file" },
  {
    "<leader>ff",
    function()
      require("telescope.builtin").find_files()
    end,
    desc = "Find File",
  },
  {
    "<leader>fg",
    function()
      require("telescope.builtin").live_grep()
    end,
    desc = "Grep",
  },
  {
    "<leader>fb",
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "Buffers",
  },
  {
    "<leader>fh",
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "Help Tags",
  },
  {
    "<leader>fr",
    function()
      require("telescope.builtin").oldfiles()
    end,
    desc = "Recent Files",
  },
  { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
  { "<leader>fs", "<cmd>w<cr>", desc = "Save File" },
  {
    "<leader>fe",
    "<cmd>Oil<cr>",
    desc = "Explore Directory",
  },
  {
    "<leader>fB",
    "<cmd>Telescope file_browser<cr>",
    desc = "File Explorer",
  },
  {
    "<leader>fp",
    "<cmd>Telescope project<cr>",
    desc = "Projects",
  },
  {
    "<leader>fm",
    "<cmd>Telescope vim_bookmarks all<cr>",
    desc = "Bookmarks",
  },

  -- ウィンドウ操作
  { "<leader>w", group = "+window" },
  { "<leader>ws", "<cmd>split<cr>", desc = "Horizontal Split" },
  { "<leader>wv", "<cmd>vsplit<cr>", desc = "Vertical Split" },
  { "<leader>wh", "<C-w>h", desc = "Move Left" },
  { "<leader>wj", "<C-w>j", desc = "Move Down" },
  { "<leader>wk", "<C-w>k", desc = "Move Up" },
  { "<leader>wl", "<C-w>l", desc = "Move Right" },
  { "<leader>wc", "<cmd>close<cr>", desc = "Close Window" },
  { "<leader>wo", "<cmd>only<cr>", desc = "Only This Window" },

  -- バッファ操作
  { "<leader>b", group = "+buffer" },
  { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
  { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
  { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
  { "<leader>bf", "<cmd>bfirst<cr>", desc = "First Buffer" },
  { "<leader>bl", "<cmd>blast<cr>", desc = "Last Buffer" },
  { "<leader>bs", "<cmd>Telescope buffers<cr>", desc = "Search Buffers" },

  -- Git操作
  { "<leader>g", group = "+git" },
  {
    "<leader>gs",
    function()
      require("gitsigns").stage_hunk()
    end,
    desc = "Stage Hunk",
  },
  {
    "<leader>gu",
    function()
      require("gitsigns").undo_stage_hunk()
    end,
    desc = "Undo Stage Hunk",
  },
  {
    "<leader>gr",
    function()
      require("gitsigns").reset_hunk()
    end,
    desc = "Reset Hunk",
  },
  {
    "<leader>gp",
    function()
      require("gitsigns").preview_hunk()
    end,
    desc = "Preview Hunk",
  },
  {
    "<leader>gb",
    function()
      require("gitsigns").blame_line()
    end,
    desc = "Blame Line",
  },
  {
    "<leader>gS",
    function()
      require("gitsigns").stage_buffer()
    end,
    desc = "Stage Buffer",
  },
  {
    "<leader>gR",
    function()
      require("gitsigns").reset_buffer()
    end,
    desc = "Reset Buffer",
  },
  {
    "<leader>gd",
    function()
      require("gitsigns").diffthis()
    end,
    desc = "Diff This",
  },
  {
    "<leader>gD",
    function()
      require("gitsigns").diffthis("~")
    end,
    desc = "Diff With HEAD",
  },
  {
    "<leader>gt",
    function()
      require("gitsigns").toggle_current_line_blame()
    end,
    desc = "Toggle Line Blame",
  },
  {
    "<leader>gT",
    function()
      require("gitsigns").toggle_deleted()
    end,
    desc = "Toggle Deleted",
  },
  {
    "<leader>gg",
    function()
      require("lazygit").lazygit()
    end,
    desc = "LazyGit",
  },
  {
    "<leader>gv",
    "<cmd>DiffviewOpen origin/main...HEAD<cr>",
    desc = "DiffView Open",
  },
  {
    "<leader>gV",
    "<cmd>DiffviewClose<cr>",
    desc = "DiffView Close",
  },
  {
    "<leader>gh",
    "<cmd>DiffviewFileHistory %<cr>",
    desc = "File History(Current)",
  },
  {
    "<leader>gH",
    "<cmd>DiffviewFileHistory<cr>",
    desc = "File History(ALL)",
  },
  {
    "<leader>gl",
    "<cmd>DiffviewLog<cr>",
    desc = "Commit Log",
  },
  { "<leader>gG", group = "+github" },
  {
    "<leader>gGo",
    "<cmd>GHOpenPR<cr>",
    desc = "Open PR",
  },
  {
    "<leader>gGr",
    "<cmd>GHReviewPR<cr>",
    desc = "Review PR",
  },
  {
    "<leader>gGf",
    "<cmd>GHPRFiles<cr>",
    desc = "PR Files",
  },
  {
    "<leader>gGc",
    "<cmd>GHPRComments<cr>",
    desc = "PR Comments",
  },
  {
    "<leader>gGi",
    "<cmd>GHOpenIssue<cr>",
    desc = "Open Issue",
  },

  -- LSP関連
  { "<leader>l", group = "+lsp" },
  {
    "<leader>lf",
    function()
      vim.lsp.buf.format({ async = true })
    end,
    desc = "Format",
  },
  {
    "<leader>lF",
    "<cmd>Format<cr>",
    desc = "Format with null-ls",
  },
  {
    "<leader>ld",
    function()
      vim.lsp.buf.definition()
    end,
    desc = "Definition",
  },
  {
    "<leader>lD",
    function()
      vim.lsp.buf.declaration()
    end,
    desc = "Declaration",
  },
  {
    "<leader>lr",
    function()
      vim.lsp.buf.references()
    end,
    desc = "References",
  },
  {
    "<leader>lR",
    "<cmd>Telescope lsp_references<cr>",
    desc = "References (Telescope)",
  },
  {
    "<leader>li",
    function()
      vim.lsp.buf.implementation()
    end,
    desc = "Implementation",
  },
  {
    "<leader>lI",
    "<cmd>Telescope lsp_implementations<cr>",
    desc = "Implementations (Telescope)",
  },
  {
    "<leader>lt",
    function()
      vim.lsp.buf.type_definition()
    end,
    desc = "Type Definition",
  },
  {
    "<leader>lT",
    function()
      local new_value = not vim.diagnostic.config().virtual_text
      vim.diagnostic.config({ virtual_text = new_value })
      print("Inline diagnostics " .. (new_value and "enabled" or "disabled"))
    end,
    desc = "Toggle Inline Diagnostics",
  },
  {
    "<leader>lh",
    function()
      vim.lsp.buf.hover()
    end,
    desc = "Hover",
  },
  {
    "<leader>ls",
    function()
      vim.lsp.buf.signature_help()
    end,
    desc = "Signature Help",
  },
  {
    "<leader>ln",
    function()
      vim.lsp.buf.rename()
    end,
    desc = "Rename",
  },
  {
    "<leader>la",
    function()
      vim.lsp.buf.code_action()
    end,
    desc = "Code Action",
  },
  {
    "<leader>lA",
    "<cmd>Telescope lsp_code_actions<cr>",
    desc = "Code Actions (Telescope)",
  },
  {
    "<leader>le",
    function()
      vim.diagnostic.open_float({ scope = "line" })
    end,
    desc = "Line Diagnostics",
  },
  {
    "<leader>lq",
    function()
      vim.diagnostic.setloclist()
    end,
    desc = "Diagnostic List",
  },
  {
    "<leader>lQ",
    "<cmd>Telescope diagnostics bufnr=0<cr>",
    desc = "Buffer Diagnostics (Telescope)",
  },
  {
    "<leader>lj",
    function()
      vim.diagnostic.goto_next({ float = true })
    end,
    desc = "Next Diagnostic",
  },
  {
    "<leader>lk",
    function()
      vim.diagnostic.goto_prev({ float = true })
    end,
    desc = "Previous Diagnostic",
  },
  {
    "<leader>lo",
    "<cmd>Telescope lsp_document_symbols<cr>",
    desc = "Document Symbols",
  },
  {
    "<leader>lO",
    "<cmd>Telescope lsp_workspace_symbols<cr>",
    desc = "Workspace Symbols",
  },
  -- ワークスペース操作
  { "<leader>lw", group = "+workspace" },
  {
    "<leader>lwa",
    function()
      vim.lsp.buf.add_workspace_folder()
    end,
    desc = "Add Folder",
  },
  {
    "<leader>lwr",
    function()
      vim.lsp.buf.remove_workspace_folder()
    end,
    desc = "Remove Folder",
  },
  {
    "<leader>lwl",
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    desc = "List Folders",
  },
  -- LSPサーバー管理
  { "<leader>lm", group = "+manage" },
  {
    "<leader>lmi",
    "<cmd>LspInfo<cr>",
    desc = "LSP Info",
  },
  {
    "<leader>lmr",
    "<cmd>LspRestart<cr>",
    desc = "Restart LSP",
  },
  {
    "<leader>lms",
    "<cmd>LspStart<cr>",
    desc = "Start LSP",
  },
  {
    "<leader>lmS",
    "<cmd>LspStop<cr>",
    desc = "Stop LSP",
  },
  {
    "<leader>lmm",
    "<cmd>Mason<cr>",
    desc = "Open Mason",
  },

  -- コード操作
  { "<leader>c", group = "+code" },
  {
    "<leader>cc",
    function()
      require("Comment.api").toggle.linewise.current()
    end,
    desc = "Comment Line",
  },
  {
    "<leader>cb",
    function()
      require("Comment.api").toggle.blockwise.current()
    end,
    desc = "Block Comment",
  },
  {
    "<leader>cs",
    function()
      require("trouble").toggle("document_diagnostics")
    end,
    desc = "Document Diagnostics",
  },
  {
    "<leader>cw",
    function()
      require("trouble").toggle("workspace_diagnostics")
    end,
    desc = "Workspace Diagnostics",
  },
  {
    "<leader>cl",
    function()
      require("trouble").toggle("loclist")
    end,
    desc = "Location List",
  },
  {
    "<leader>cq",
    function()
      require("trouble").toggle("quickfix")
    end,
    desc = "Quickfix List",
  },
  {
    "<leader>cf",
    function()
      vim.lsp.buf.format()
    end,
    desc = "Format",
  },
  {
    "<leader>ca",
    function()
      vim.lsp.buf.code_action()
    end,
    desc = "Code Action",
  },

  -- 検索/ナビゲーション
  { "<leader>s", group = "+search" },
  {
    "<leader>sf",
    function()
      require("telescope.builtin").find_files()
    end,
    desc = "Find Files",
  },
  {
    "<leader>sg",
    function()
      require("telescope.builtin").live_grep()
    end,
    desc = "Grep",
  },
  {
    "<leader>sb",
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "Buffers",
  },
  {
    "<leader>sh",
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "Help Tags",
  },
  {
    "<leader>sm",
    function()
      require("telescope.builtin").marks()
    end,
    desc = "Marks",
  },
  {
    "<leader>sr",
    function()
      require("telescope.builtin").registers()
    end,
    desc = "Registers",
  },
  {
    "<leader>sk",
    function()
      require("telescope.builtin").keymaps()
    end,
    desc = "Keymaps",
  },
  {
    "<leader>sc",
    function()
      require("telescope.builtin").commands()
    end,
    desc = "Commands",
  },
  {
    "<leader>ss",
    function()
      require("telescope.builtin").current_buffer_fuzzy_find()
    end,
    desc = "Search in Buffer",
  },
  {
    "<leader>st",
    function()
      require("telescope.builtin").treesitter()
    end,
    desc = "Treesitter Symbols",
  },
  { "<leader>sn", "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
  {
    "<leader>sl",
    function()
      require("telescope.builtin").resume()
    end,
    desc = "Last Search",
  },

  -- Trouble
  { "<leader>x", group = "+trouble" },
  {
    "<leader>xx",
    function()
      require("trouble").toggle()
    end,
    desc = "Toggle Trouble",
  },
  {
    "<leader>xw",
    function()
      require("trouble").toggle("workspace_diagnostics")
    end,
    desc = "Workspace Diagnostics",
  },
  {
    "<leader>xd",
    function()
      require("trouble").toggle("document_diagnostics")
    end,
    desc = "Document Diagnostics",
  },
  {
    "<leader>xl",
    function()
      require("trouble").toggle("loclist")
    end,
    desc = "Location List",
  },
  {
    "<leader>xq",
    function()
      require("trouble").toggle("quickfix")
    end,
    desc = "Quickfix List",
  },

  -- 追加機能
  {
    "<leader>L",
    function()
      vim.schedule(function()
        if require("hlslens").exportLastSearchToQuickfix() then
          vim.cmd("cw")
        end
      end)
      vim.cmd("noh")
      return ":noh<CR>"
    end,
    desc = "Export search to quickfix and clear highlight",
    expr = true,
  },
  { "<leader>n", "<cmd>Navbuddy<cr>", desc = "Navigation" },

  -- 既存のテストマッピング (コメントアウトした部分)
  { "<leader>t", group = "+test" },
  { "<leader>tn", "<cmd>Neotest run<cr>", desc = "Run Nearest Test" },
  { "<leader>tf", "<cmd>Neotest run file<cr>", desc = "Run File Test" },
}

-- ビジュアルモード用のマッピング
local visual_mappings = {
  { mode = "v", "<leader>c", group = "+code" },
  {
    mode = "v",
    "<leader>cc",
    function()
      require("Comment.api").toggle.linewise(vim.fn.visualmode())
    end,
    desc = "Comment Lines",
  },
  {
    mode = "v",
    "<leader>cb",
    function()
      require("Comment.api").toggle.blockwise(vim.fn.visualmode())
    end,
    desc = "Block Comment",
  },
  {
    mode = "v",
    "<leader>cf",
    function()
      vim.lsp.buf.format({
        range = { start = vim.api.nvim_buf_get_mark(0, "<"), ["end"] = vim.api.nvim_buf_get_mark(0, ">") },
      })
    end,
    desc = "Format Selection",
  },
  {
    mode = "v",
    "<leader>ca",
    function()
      vim.lsp.buf.code_action()
    end,
    desc = "Code Action",
  },

  { mode = "v", "<leader>g", group = "+git" },
  {
    mode = "v",
    "<leader>gs",
    function()
      require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end,
    desc = "Stage Selection",
  },
  {
    mode = "v",
    "<leader>gr",
    function()
      require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end,
    desc = "Reset Selection",
  },
}

-- すべてのマッピングを登録
wk.add(mappings)
wk.add(visual_mappings)
