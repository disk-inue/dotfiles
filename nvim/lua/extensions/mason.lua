require("mason").setup({
  ui = {
    check_outdated_packages_on_open = false,
    border = "single",
  },
})

require("mason-lspconfig").setup()
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
    })
  end,
})

require("mason-null-ls").setup({
  automatic_setup = true,
  handlers = {},
})
