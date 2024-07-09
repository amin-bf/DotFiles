local opts = {
  defaults = {
    vimgrep_arguments = {"rg", "-L", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
                         "--smart-case"},
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55
      },
      vertical = {
        mirror = false
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {"node_modules"},
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = {"truncate"},
    winblend = 0,
    border = {},
    borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
    color_devicons = true,
    set_env = {
      ["COLORTERM"] = "truecolor"
    }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = {
        ["q"] = require("telescope.actions").close
      }
    }
  },

  extensions_list = {'dap', 'i23'}
}

local telescope = require 'telescope'

return {
  init = function()
    telescope.setup(opts)

    for _, ext in ipairs(opts.extensions_list) do
      telescope.load_extension(ext)
    end
  end,
  initDap = function()
    local dap = require "dap"

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = {"${port}"}
      }
    }

    for _, language in ipairs {"typescript" --[['javascript'--]] } do
      dap.configurations[language] = {{
        type = "pwa-node",
        request = "attach",
        name = "Attach to docker",
        skipFiles = {"<node_internals>/**", "node_modules/**"},
        localRoot = vim.fn.getcwd(),
        processId = require("dap.utils").processId,
        remoteRoot = "/usr/src/api",
        port = 9229
      }}
    end

    require("dap-vscode-js").setup {
      debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
      adapters = { --[['pwa-node',--]] "pwa-chrome" --[['pwa-msedge', 'node-terminal', 'pwa-extensionHost'--]] }
    }

    for _, language in ipairs {"svelte"} do
      require("dap").configurations[language] = {{
        type = "pwa-chrome",
        name = "Launch Chrome to debug client",
        request = "launch",
        url = "https://localhost:9000",
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}/src",
        -- skip files from vite's hmr
        skipFiles = {"**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*"},
        runtimeArgs = {'--profile-directory=debug-profile', "--aminIsHere=45"},
        runtimeExecutable = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
      }}
    end

    local dapui = require "dapui"
    require("dapui").setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open {
        reset = true
      }
    end
    dap.listeners.after.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.after.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end
}
