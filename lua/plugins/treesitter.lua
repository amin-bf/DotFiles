return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "lua", "vim", "vimdoc", "html", "css", "javascript", "typescript", "tsx", "c", "markdown",
      "markdown_inline", "vue" },

    highlight = {
      enable = true,
      use_languagetree = true
    },

    indent = {
      enable = true
    }
  }
}
