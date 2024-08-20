return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', { 'arkav/lualine-lsp-progress' } },
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      theme = 'OceanicNext',
      component_separators = {
        left = '',
        right = ''
      },
      section_separators = {
        left = '',
        right = ''
      },
      disabled_filetypes = {
        statusline = {},
        winbar = {}
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000
      }
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = { 'filename', function()
        return require("lspsaga.symbol.winbar").get_bar()
      end },
      lualine_x = { {
        'diagnostics',

        -- Table of diagnostic sources, available sources are:
        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
        -- or a function that returns a table as such:
        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
        sources = { 'nvim_lsp', 'nvim_diagnostic', 'coc' },

        -- Displays diagnostics for the defined severity types
        sections = { 'error', 'warn', 'info', 'hint' },

        diagnostics_color = {
          -- Same values as the general color option can be used here.
          error = 'DiagnosticError', -- Changes diagnostics' error color.
          warn = 'DiagnosticWarn',   -- Changes diagnostics' warn color.
          info = 'DiagnosticInfo',   -- Changes diagnostics' info color.
          hint = 'DiagnosticHint'    -- Changes diagnostics' hint color.
        },
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' '
        },
        colored = true,           -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false    -- Show diagnostics even if there are none.
      }, {
        'lsp_progress',
        display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
        separators = {
          percentage = {
            pre = '',
            post = '%% '
          },
          title = {
            pre = '',
            post = ': '
          },
          lsp_client_name = {
            pre = '[',
            post = ']'
          }
        },
        timer = {
          progress_enddelay = 2000,
          spinner = 50,
          lsp_client_name_enddelay = 20000
        },
        spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' }

      } --[[, 'fileformat', 'filetype']] },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
}
