local opts = {
  ensure_installed = { -- lua stuff
  "lua-language-server", -- web dev stuff
  "css-lsp", "html-lsp", "typescript-language-server", "prettier", "vue-language-server", "eslint-lsp",
  "js-debug-adapter", "chrome-debug-adapter"}
}

return {
  init = function()
    require("mason").setup(opts)
    require("mason-lspconfig").setup()

    -- custom nvchad cmd to install all mason binaries listed
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
    end, {})
  end
}
