---@diagnostic disable-next-line: undefined-global
local vim = vim -- This tells the LS that `vim` is a valid global

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function grep_at_current_tree_node()
    local node = require('nvim-tree.lib').get_node_at_cursor()
    if not node then
      return
    end
    require('telescope.builtin').live_grep({
      search_dirs = { node.absolute_path }
    })
  end

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'gr', grep_at_current_tree_node, opts('Live Grep'))
  vim.keymap.set('n', '<leader>gr', grep_at_current_tree_node, opts('Live Grep'))
  --   vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { {
    'famiu/bufdelete.nvim',
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end
  } },
  opts = {
    on_attach = my_on_attach,
    filters = {
      dotfiles = false,
      exclude = { vim.fn.stdpath "config" .. "/lua/custom" }
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false
    },
    view = {
      adaptive_size = false,
      side = "left",
      width = 30,
      preserve_window_proportions = true
    },
    git = {
      enable = false,
      ignore = true
    },
    filesystem_watchers = {
      enable = true
    },
    actions = {
      open_file = {
        resize_window = true
      }
    },
    renderer = {
      root_folder_label = false,
      highlight_git = false,
      highlight_opened_files = "none",

      indent_markers = {
        enable = false
      },

      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false
        },

        glyphs = {
          default = "󰈚",
          symlink = "",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = ""
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌"
          }
        }
      }
    }
  },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
}
