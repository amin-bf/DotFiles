---@diagnostic disable-next-line: undefined-global
local vim = vim -- This tells the LS that `vim` is a valid global
require "defaults"
require "config.lazy"
require 'mappings'


vim.cmd("colorscheme nightfox")
local symbols = { Error = "", Info = "󰋼", Hint = "", Warn = "" }

for name, icon in pairs(symbols) do
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end
