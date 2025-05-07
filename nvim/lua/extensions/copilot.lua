require("copilot").setup({
  panel = { enabled = false },
  suggestion = { 
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<C-y>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    ["*"] = true,
  },
  copilot_node_command = 'node',
})
