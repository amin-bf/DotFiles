return {
  'akinsho/bufferline.nvim',
  event = "VeryLazy",
  opts = {
    options = {
      separator_style = 'slant',
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' }
      },
      diagnostics = 'nvim_lsp',
      color_icons = true,
      show_tab_indicators = true,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        -- if context.buffer:current() then
        --   return ''
        -- end

        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      offsets = { {
        filetype = "NvimTree",
        text = function()
          return "NVIMTREE TEXT"
          -- return vim.fn.getcwd()
        end,
        -- highlight = "Directory",
        text_align = "left",
        separator = true
      } }
    },
    highlights = {
      error_diagnostic = {
        fg = '#af0000',
        sp = '#87ff00'
      },
      error_diagnostic_visible = {
        fg = '#af0000'
      },
      error_diagnostic_selected = {
        fg = '#af0000',
        sp = '#87ff00',
        bold = true,
        italic = true
      },
      hint_diagnostic = {
        fg = '#87ffff',
        sp = '#87ff00'
      },
      hint_diagnostic_visible = {
        fg = '#87ffff'
      },
      hint_diagnostic_selected = {
        fg = '#87ffff',
        sp = '#87ff00',
        bold = true,
        italic = true
      }
    }

  }
}
