local opts = {
  lsp_fallback = true,

  formatters_by_ft = {
    javascript = {"prettier"},
    typescript = {"prettier"},
    vue = {"prettier"},
    css = {"prettier"},
    html = {"prettier"}
  },

  -- adding same formatter for multiple filetypes can look too much work for some
  -- instead of the above code you could just use a loop! the config is just a table after all!

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true
  }
}

return {
  init = function()
    require("conform").setup(opts)

    -- custom nvchad cmd to install all mason binaries listed
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
    end, {})
  end
}
