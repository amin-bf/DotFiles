local opts = {
  ensure_installed = {"lua", "vim", "vimdoc", "html", "css", "javascript", "typescript", "tsx", "c", "markdown",
                      "markdown_inline", "vue"},

  highlight = {
    enable = true,
    use_languagetree = true
  },

  indent = {
    enable = true
  }
}

return {
  init = function()
    require("nvim-treesitter.configs").setup(opts)
  end
}
