-- Mason自体の設定
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
    keymaps = {
      -- カスタムキーマップ
      toggle_package_expand = "<CR>",
      install_package = "i",
      update_package = "u",
      check_package_version = "c",
      update_all_packages = "U",
      check_outdated_packages = "C",
      uninstall_package = "X",
      cancel_installation = "<C-c>",
      apply_language_filter = "<C-f>",
    },
    border = "rounded",
    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
  },
  max_concurrent_installers = 4, -- 同時インストール数
  github = {
    download_url_template = "https://github.com/%s/releases/download/%s/%s",
  },
  log_level = vim.log.levels.INFO,
})

-- 基本機能のみ有効化
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",         -- TypeScript
    "eslint",        -- ESLint
    "html",          -- HTML
    "cssls",         -- CSS
    "jsonls",        -- JSON
    "yamlls",        -- YAML
    "stylelint_lsp", -- Stylelint (CSSリンター)
    "lua_ls",        -- Lua
    "bashls",        -- Bash
    "marksman",      -- Markdown
    "ltex",          -- テキスト校正
  },

  -- LSPがmasonでインストールされたあとの自動設定
  handlers = {
    function(server_name)
      -- 各LSPサーバーの設定
      local server_configs = {
        -- Lua LSP
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }, -- Vimグローバル変数を認識
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true), -- Neovim APIを認識
                checkThirdParty = false,                           -- サードパーティチェックは無効化
              },
              telemetry = {
                enable = false, -- テレメトリは無効化
              },
            },
          },
        },

        -- TypeScript Language Server
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
        },

        -- スタイリング
        stylelint_lsp = {
          filetypes = { "css", "scss", "less", "sass" },
          settings = {
            stylelintplus = {
              autoFixOnFormat = true,
            },
          },
        },

        -- ESLint
        eslint = {
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
          settings = {
            format = true, -- 保存時にフォーマット
          },
        },

        -- 日本語校正LSP
        ltex = {
          settings = {
            ltex = {
              language = "ja",
              additionalRules = { enablePickyRules = true },
            },
          },
        },
      }

      -- サーバー固有の設定がある場合はそれを使用
      local config = server_configs[server_name] or {}

      -- 共通の設定を適用
      config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- サーバーをセットアップ
      require("lspconfig")[server_name].setup(config)
    end,
  },
})


require("mason-null-ls").setup({
  ensure_installed = {
    "prettier", -- 各種フォーマット
    "gitsigns", -- Gitの統合機能
  },
  automatic_installation = true,
  automatic_setup = false, -- 手動で設定する
  handlers = {},
})
