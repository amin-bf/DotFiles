return {
  "lewis6991/gitsigns.nvim",
  dependencies = { {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    -- optional for floating window border decoration
    dependencies = { "nvim-lua/plenary.nvim" },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = { {
      "<leader>lg",
      "<cmd>LazyGit<cr>",
      desc = "LazyGit"
    } }
  }, {
    'gorbit99/codewindow.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local codewindow = require('codewindow')
      codewindow.setup({
        screen_bounds = 'background',
        events = { 'TextChanged', 'BufWritePost', 'InsertLeave', 'DiagnosticChanged', 'FileWritePost' }
      })
      codewindow.apply_default_keybinds()
    end
  }, {
    "github/copilot.vim",
    event = { "BufReadPost", "BufNewFile" }
  }, {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "CopilotChatOpen" },
    branch = "canary",
    dependencies = { { "github/copilot.vim" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }            -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
      window = {
        debug = true,         -- Enable debugging
        layout = "float",     -- 'vertical', 'horizontal', 'float'
        -- Options below only apply to floating windows
        relative = "cursor",  -- 'editor', 'win', 'cursor', 'mouse'
        border = "single",    -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        width = 1,            -- fractional width of parent
        height = 0.4,         -- fractional height of parent
        row = 1,              -- row position of the window, default is centered
        col = nil,            -- column position of the window, default is centered
        title = "Copilot Chat", -- title of chat window
        footer = nil,         -- footer of chat window
        zindex = 1            -- determines if window is on top or below other floating windows
      }
    }
    -- See Commands section for default commands if you want to lazy load on them
  } },
  event = { "BufReadPre", "BufNewFile", "User FilePost" },
  opts = {
    signs = {
      add = {
        text = "│"
      },
      change = {
        text = "│"
      },
      delete = {
        text = "󰍵"
      },
      topdelete = {
        text = "‾"
      },
      changedelete = {
        text = "~"
      },
      untracked = {
        text = "│"
      }
    }
  }
}
