---@diagnostic disable-next-line: undefined-global
local vim = vim -- This tells the LS that `vim` is a valid global
local lspconfig = require "lspconfig"

vim.api.nvim_create_autocmd({'BufWritePost'}, {
  callback = function()
    require('lint').try_lint()
  end
})

return {
  init = function()
    require('lint').linters_by_ft = {
      javascript = {'eslint'},
      typescript = {'eslint'},
      vue = {'eslint'}
    }
  end
}

