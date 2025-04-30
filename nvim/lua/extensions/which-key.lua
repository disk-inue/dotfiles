require("which-key").setup({})

local wk = require("which-key")

wk.add({
  { "<leader>f", group = "+file" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep", mode = "n" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers", mode = "n" },
  { "<leader>g", group = "+git" },
  { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status", mode = "n" },
  { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git Diff", mode = "n" },
  { "<leader>t", group = "+test" },
  { "<leader>tn", "<cmd>Neotest run<cr>", desc = "Run Nearest Test", mode = "n" },
  { "<leader>tf", "<cmd>Neotest run file<cr>", desc = "Run File Test", mode = "n" },
})
