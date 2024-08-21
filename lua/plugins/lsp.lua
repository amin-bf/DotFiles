---@diagnostic disable-next-line: undefined-global
local vim = vim -- This tells the LS that `vim` is a valid global

local servers = { "lua_ls", "html", "cssls", "volar", "tsserver", "rust_analyzer" }

local on_init = function(client, _)
  client.server_capabilities.semanticTokensProvider = nil
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = {
    valueSet = { 1 }
  },
  resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" }
  }
}

return {
  "neovim/nvim-lspconfig",
  priority = 100,
  event = { "BufReadPre", "BufNewFile", "User FilePost" },
  opts = {
    ensure_installed = {     -- lua stuff
      "lua-language-server", -- web dev stuff
      "css-lsp", "html-lsp", "typescript-language-server", "prettier", "vue-language-server", "eslint-lsp",
      "js-debug-adapter", "chrome-debug-adapter", "rust-analyzer" }
  },
  dependencies = { {
    'simrat39/rust-tools.nvim',
    ft = "rust",
  }, {
    "LunarVim/breadcrumbs.nvim",
    dependencies = { { "SmiteshP/nvim-navic" } }
  }, {
    'nvimdev/lspsaga.nvim',
    event = "LspAttach",
    opts = {
      symbol_in_winbar = {
        enable = false,
        folder_level = 1
      }
    }
  }, { "williamboman/mason-lspconfig.nvim" }, {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
  } },
  config = function(_, opts)
    -- disable semantic tokens
    require("mason").setup(opts)
    require("mason-lspconfig").setup()

    local lspconfig = require "lspconfig"
    for _, server in ipairs(servers) do
      local settings = {
        on_init = on_init,
        capabilities = capabilities
      }
      if server == "lua_ls" then
        settings.Lua = {
          diagnostics = {
            globals = { "vim" }
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
              ["/opt/homebrew/Cellar/neovim/0.10.1/share/nvim/runtime/lua"] = true,
              ["/opt/homebrew/Cellar/neovim/0.10.1/share/nvim/runtime/lua/vim/lsp"] = true,
              ["/Users/amin/.local/share/nvim/lazy/lspsaga.nvim/lua/lspsaga"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000
          }
        }
      end
      if server == "tsserver" then
        settings.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }
        settings.init_options = {
          preferences = {
            disableSuggestions = true
          },
          plugins = { {
            name = "@vue/typescript-plugin",
            location = "/opt/homebrew/lib/node_modules/@vue/typescript-plugin",
            languages = { "vue", "javascript", "typescript" }
          } }
        }
      end
      -- if server == "rust_analyzer" then
      --   settings.settings = {
      --     ["rust-analyzer"] = {
      --       checkOnSave = {
      --         command = "clippy"
      --       },
      --       cargo = {
      --         allFeatures = true
      --       }
      --     }
      --   }
      --   settings.filetypes = { "rust" }
      --   settings.root_dir = lspconfig.util.root_pattern("Cargo.toml")
      -- end

      lspconfig[server].setup(settings)
    end

    local rt = require('rust-tools')

    -- local mason_registry = require("mason-registry")
    -- local codelldb = mason_registry.get_package("codelldb")
    -- local extension_path = codelldb:get_install_path() .. '/extension/'
    -- local codelldb_path = extension_path .. 'adapter/codelldb'
    -- local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'


    rt.setup({
      -- dap = {
      --   adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
      -- },
      server = {
        capabilities = capabilities,
        on_init = on_init,
        -- on_attach = function(_, bufnr)
        --   vim.keymap.set("n", "<leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
        --   vim.keymap.set("n", "<leader>a", rt.code_action_group.code_actions_group, { buffer = bufnr })
        -- end
      },
      tools = {
        hover_actions = {
          auto_focus = true
        }
      }
    })
      
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
    end, {})

    require("nvim-navic").setup {
      lsp = {
        auto_attach = true
      }
    }

    require("breadcrumbs").setup()
  end
}
