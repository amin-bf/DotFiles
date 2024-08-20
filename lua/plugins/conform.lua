return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    lsp_fallback = true,

    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      vue = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      lua = { "lua-format" },
    },




    -- adding same formatter for multiple filetypes can look too much work for some
    -- instead of the above code you could just use a loop! the config is just a table after all!

    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true
    }
  }
}
