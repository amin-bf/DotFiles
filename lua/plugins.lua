local table = {"nvim-lua/plenary.nvim", {
  "williamboman/mason.nvim",
  cmd = {"Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate"},
  config = function()
    require"configs.mason".init()
  end
}, {
  "nvim-tree/nvim-tree.lua",
  dependencies = {{
    'famiu/bufdelete.nvim',
    "nvim-tree/nvim-web-devicons",
    config = function()
      require"configs.nvimtree".initDevicon()
    end
  }},
  cmd = {"NvimTreeToggle", "NvimTreeFocus"},
  config = function()
    require"configs.nvimtree".init()
  end
}, {
  "lukas-reineke/indent-blankline.nvim",
  lazy = false,
  main = "ibl",
  opts = {},
  config = function()
    require("ibl").setup()
  end
}, {
  "EdenEast/nightfox.nvim",
  priority = 1000
}, {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    require"configs.lint".init()
  end
}, {
  "neovim/nvim-lspconfig",
  event = {"BufReadPre", "BufNewFile", "User FilePost"},
  config = function()
    require"configs.lsp".init()
  end
}, -- load luasnips + cmp related in insert mode only
{
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {{"onsails/lspkind.nvim"}, {
    -- snippet plugin
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    opts = {
      history = true,
      updateevents = "TextChanged,TextChangedI"
    },
    config = function(_, opts)
      require"configs.cmp".initLuaSnip()
    end
  }, -- autopairing of (){}[] etc
  {
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {},
      disable_filetype = {"TelescopePrompt", "vim"}
    },
    config = function(_, opts)
      require"configs.cmp".initAutopair()
    end
  }, -- cmp sources plugins
  {"saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path"}},
  config = function(_, opts)
    require"configs.cmp".init()
  end
}, {
  'nvim-lualine/lualine.nvim',
  dependencies = {'nvim-tree/nvim-web-devicons'},
  event = "VeryLazy",
  config = function()
    require"configs.lualine".init()
  end
}, {
  "max397574/better-escape.nvim",
  event = "InsertEnter",
  config = function()
    require("better_escape").setup()
  end
}, {
  "stevearc/conform.nvim",
  --  for users those who want auto-save conform + lazyloading!
  event = "BufWritePre",
  config = function()
    require"configs.conform".init()
  end
}, {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {"nvim-telescope/telescope-dap.nvim", "HUAHUAI23/telescope-dapzzzz", {
    "mfussenegger/nvim-dap",
    config = function()
      require"configs.telescope".initDap()
    end
  }, {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"nvim-treesitter/nvim-treesitter", "mxsdev/nvim-dap-vscode-js", -- build debugger from source
    {
      "microsoft/vscode-js-debug",
      version = "1.x",
      build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
    }, {"nvim-neotest/nvim-nio"}}
  }},
  config = function()
    require"configs.telescope".init()
  end
}, {
  "zbirenbaum/nvterm",
  config = function()
    require("nvterm").setup()
  end
}, {
  "lewis6991/gitsigns.nvim",
  dependencies = {{'petertriho/nvim-scrollbar'}},
  event = {"BufReadPre", "BufNewFile", "User FilePost"},
  opts = function()
    return {
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
  end,
  config = function(_, opts)
    require("gitsigns").setup(opts)
  end
}, {
  "kdheepak/lazygit.nvim",
  cmd = {"LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile"},
  -- optional for floating window border decoration
  dependencies = {"nvim-lua/plenary.nvim"},
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {{
    "<leader>lg",
    "<cmd>LazyGit<cr>",
    desc = "LazyGit"
  }}
}, {
  'akinsho/bufferline.nvim',
  event = "VeryLazy",
  config = function()
    require"configs.bufferline".init()
  end
}, {
  "nvim-treesitter/nvim-treesitter",
  event = {"BufReadPost", "BufNewFile"},
  cmd = {"TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo"},
  build = ":TSUpdate",
  config = function()
    require"configs.treesitter".init()
  end
}, {
  'gorbit99/codewindow.nvim',
  event = {"BufReadPost", "BufNewFile"},
  config = function()
    local codewindow = require('codewindow')
    codewindow.setup({
      screen_bounds = 'background',
      events = {'TextChanged', 'BufWritePost', 'InsertLeave', 'DiagnosticChanged', 'FileWritePost'}
    })
    codewindow.apply_default_keybinds()
  end
}, {
  "github/copilot.vim",
  event = {"BufReadPost", "BufNewFile"}
}, {
  "CopilotC-Nvim/CopilotChat.nvim",
  event = {"BufReadPost", "BufNewFile"},
  cmd = {"CopilotChatOpen"},
  branch = "canary",
  dependencies = {{"github/copilot.vim"}, -- or github/copilot.vim
  {"nvim-lua/plenary.nvim"} -- for curl, log wrapper
  },
  opts = {
    debug = true, -- Enable debugging
    -- See Configuration section for rest
    window = {
      debug = true, -- Enable debugging
      layout = "float", -- 'vertical', 'horizontal', 'float'
      -- Options below only apply to floating windows
      relative = "cursor", -- 'editor', 'win', 'cursor', 'mouse'
      border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
      width = 1, -- fractional width of parent
      height = 0.4, -- fractional height of parent
      row = 1, -- row position of the window, default is centered
      col = nil, -- column position of the window, default is centered
      title = "Copilot Chat", -- title of chat window
      footer = nil, -- footer of chat window
      zindex = 1 -- determines if window is on top or below other floating windows
    }
  }
  -- See Commands section for default commands if you want to lazy load on them
}, {
  "numToStr/Comment.nvim",
  keys = {{
    "gcc",
    mode = "n",
    desc = "Comment toggle current line"
  }, {
    "gc",
    mode = {"n", "o"},
    desc = "Comment toggle linewise"
  }, {
    "gc",
    mode = "x",
    desc = "Comment toggle linewise (visual)"
  }, {
    "gbc",
    mode = "n",
    desc = "Comment toggle current block"
  }, {
    "gb",
    mode = {"n", "o"},
    desc = "Comment toggle blockwise"
  }, {
    "gb",
    mode = "x",
    desc = "Comment toggle blockwise (visual)"
  }},
  config = function(_, opts)
    require("Comment").setup(opts)
  end
}, {'arkav/lualine-lsp-progress'}, {
  "folke/which-key.nvim",
  keys = {"<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g"},
  cmd = "WhichKey",
  config = function(_, opts)
    require("which-key").setup(opts)
  end
}}

return table
