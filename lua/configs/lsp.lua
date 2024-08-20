---@diagnostic disable-next-line: undefined-global
local vim = vim -- This tells the LS that `vim` is a valid global
local lspconfig = require "lspconfig"

-- disable semantic tokens
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

local servers = { "lua_ls", "html", "cssls", "volar", "tsserver", "rust_analyzer" }

local masonOpts = {
  ensure_installed = {   -- lua stuff
    "lua-language-server", -- web dev stuff
    "css-lsp", "html-lsp", "typescript-language-server", "prettier", "vue-language-server", "eslint-lsp",
    "js-debug-adapter", "chrome-debug-adapter" }
}

return {
  init = function()
    require("mason").setup(masonOpts)
    require("mason-lspconfig").setup()

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
      vim.cmd("MasonInstall " .. table.concat(masonOpts.ensure_installed, " "))
    end, {})

    require('lspsaga').setup({
      symbol_in_winbar = {
        enable = false,
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
