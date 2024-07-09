---@diagnostic disable-next-line: undefined-global
local vim = vim -- This tells the LS that `vim` is a valid global
require "defaults"

print(vim.fn.stdpath('data'))

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system(
    {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
     lazypath})
end
vim.opt.rtp:prepend(lazypath)

local plugins = require("plugins")

require("lazy").setup(plugins, {
  defaults = {
    lazy = true
  },
  install = {
    colorscheme = {"nvchad"}
  },

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = ""
    }
  },

  performance = {
    rtp = {
      disabled_plugins = {"2html_plugin", "tohtml", "getscript", "getscriptPlugin", "gzip", "logipat", "netrw",
                          "netrwPlugin", "netrwSettings", "netrwFileHandlers", "matchit", "tar", "tarPlugin",
                          "rrhelper", --[["spellfile_plugin",]] "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor",
                          "rplugin", "syntax", "synmenu", "optwin", "compiler", "bugreport", "ftplugin"}
    }
  }
})

require 'mappings'

local C = require("nightfox.lib.color")
local Shade = require("nightfox.lib.shade")

local bg = C("#222d36")
local fg = C("#f2f4f8")

local palette = {
  black = Shade.new("#181818", 0.15, -0.15),
  red = Shade.new("#f14c4c", 0.15, -0.15),
  green = Shade.new("#89d185", 0.15, -0.15), -- #25be6a or #42BE65
  yellow = Shade.new("#cca700", 0.15, -0.15),
  blue = Shade.new("#3794ff", 0.15, -0.15),
  magenta = Shade.new("#d670d6", 0.15, -0.15),
  cyan = Shade.new("#29b8db", 0.15, -0.15),
  white = Shade.new("#dfdfe0", 0.15, -0.15),
  orange = Shade.new("#d18616", 0.15, -0.15),
  pink = Shade.new("#c184bc", 0.15, -0.15),
  purple = Shade.new('#c586c0', 0.15, -0.15),
  skyBlue = Shade.new('#569cd6', 0.15, -0.15),
  cream = Shade.new('#dcdcaa', 0.15, -0.15),

  comment = bg:blend(fg, 0.3):to_css(),

  bg0 = bg:brighten(-10):to_css(), -- Dark bg (status line and float)
  bg1 = bg:to_css(), -- Default bg
  bg2 = bg:brighten(6):to_css(), -- Lighter bg (colorcolm folds)
  bg3 = bg:brighten(12):to_css(), -- Lighter bg (cursor line)
  bg4 = bg:brighten(24):to_css(), -- Conceal, border fg

  fg0 = fg:brighten(6):to_css(), -- Lighter fg
  fg1 = fg:to_css(), -- Default fg
  fg2 = fg:brighten(-24):to_css(), -- Darker fg (status line)
  fg3 = fg:brighten(-48):to_css(), -- Darker fg (line numbers, fold colums)

  sel0 = bg:brighten(15):to_css(), -- Popup bg, visual selection bg
  sel1 = "#525253" -- Popup sel bg, search bg
}

local function generate_spec(pal)
  -- stylua: ignore start
  local spec = {
    bg0 = pal.bg0, -- Dark bg (status line and float)
    bg1 = pal.bg1, -- Default bg
    bg2 = pal.bg2, -- Lighter bg (colorcolm folds)
    bg3 = pal.bg3, -- Lighter bg (cursor line)
    bg4 = pal.bg4, -- Conceal, border fg

    fg0 = pal.fg0, -- Lighter fg
    fg1 = pal.fg1, -- Default fg
    fg2 = pal.fg2, -- Darker fg (status line)
    fg3 = pal.fg3, -- Darker fg (line numbers, fold colums)

    sel0 = pal.sel0, -- Popup bg, visual selection bg
    sel1 = pal.sel1 -- Popup sel bg, search bg
  }

  spec.syntax = {
    bracket = spec.fg2, -- Brackets and Punctuation
    builtin0 = pal.purple.bright, -- Builtin variable
    builtin1 = pal.cyan.bright, -- Builtin type
    builtin2 = pal.cyan.dim, -- Builtin const
    builtin3 = pal.red.bright, -- Not used
    comment = pal.comment, -- Comment
    conditional = pal.magenta.bright, -- Conditional and loop
    const = pal.orange.bright, -- Constants, imports and booleans
    dep = spec.fg3, -- Deprecated
    field = pal.skyBlue.bright, -- Field
    func = pal.cream.base, -- Functions and Titles
    ident = pal.cyan.base, -- Identifiers
    keyword = pal.skyBlue.base, -- Keywords
    number = pal.orange.base, -- Numbers
    operator = spec.fg2, -- Operators
    preproc = pal.pink.bright, -- PreProc
    regex = pal.yellow.bright, -- Regex
    statement = pal.magenta.base, -- Statements
    string = '#cb8f77', -- Strings
    type = pal.cyan.dim, -- Types
    variable = pal.white.base -- Variables
  }

  spec.diag = {
    error = pal.red.base,
    warn = pal.orange.base,
    info = pal.blue.base,
    hint = pal.cyan.base,
    ok = pal.green.base
  }

  spec.diag_bg = {
    error = C(spec.bg1):blend(C(spec.diag.error), 0.15):to_css(),
    warn = C(spec.bg1):blend(C(spec.diag.warn), 0.15):to_css(),
    info = C(spec.bg1):blend(C(spec.diag.info), 0.15):to_css(),
    hint = C(spec.bg1):blend(C(spec.diag.hint), 0.15):to_css(),
    ok = C(spec.bg1):blend(C(spec.diag.ok), 0.15):to_css()
  }

  spec.diff = {
    add = C(spec.bg1):blend(C(pal.green.dim), 0.15):to_css(),
    delete = C(spec.bg1):blend(C(pal.red.dim), 0.15):to_css(),
    change = C(spec.bg1):blend(C(pal.blue.dim), 0.15):to_css(),
    text = C(spec.bg1):blend(C(pal.cyan.dim), 0.3):to_css()
  }

  spec.git = {
    add = pal.green.base,
    removed = pal.red.base,
    changed = pal.yellow.base,
    conflict = pal.orange.base,
    ignored = pal.comment
  }

  -- stylua: ignore stop

  return spec
end

local opts = {
  options = {
    styles = {
      comments = "italic"
      -- functions = "italic",
      -- keywords = "italic",
      -- strings = "italic",
      -- variables = "italic",
    }
  },
  palettes = {
    nightfox = palette
  },
  specs = {
    nightfox = generate_spec(palette)
  }
}

local nightfox = require("nightfox")
nightfox.setup(opts)

-- Load the colorscheme
vim.cmd("colorscheme nightfox")

-- local palette = require("nightfox.palette")
-- local spec = require("nightfox.spec")
-- local colorPalette = palette.load("nightfox")
-- local foxSpec = spec.load("nightfox")
-- print(vim.inspect(foxSpec))
-- -- print(vim.inspect(colorPalette))
-- print(vim.inspect(foxSpec))
