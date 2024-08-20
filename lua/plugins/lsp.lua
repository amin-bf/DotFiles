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
    event = "BufReadPre",
    config = function()
      require('rust-tools').setup({
        server = {
          capabilities = vim.lsp.protocol.make_client_capabilities()
        }
      })
    end
  }, {
    "LunarVim/breadcrumbs.nvim",
    dependencies = { { "SmiteshP/nvim-navic" } }
  }, { 'nvimdev/lspsaga.nvim' }, { "williamboman/mason-lspconfig.nvim" }, {
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
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true
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

      lspconfig[server].setup(settings)
    end

    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
    end, {})

    require('lspsaga').setup({
      symbol_in_winbar = {
        enable = false,
        folder_level = 1
      }
    })
    require("nvim-navic").setup {
      lsp = {
        auto_attach = true
      }
    }

    require("breadcrumbs").setup()
  end
}
