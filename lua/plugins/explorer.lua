return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  "MunifTanjim/nui.nvim", "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
                  "famiu/bufdelete.nvim"},
  opts = {
    event_handlers = {{
      event = "neo_tree_popup_buffer_enter",
      handler = function(arg)
        vim.cmd [[setlocal nofoldenable]]
      end
    }},
    filesystem = {
      window = {
        mappings = {
          ["gr"] = function(state)
            local node = state.tree:get_node()
            if not node then
              return
            end
            require('telescope.builtin').live_grep({
              search_dirs = {node.path}
            })
          end
        }
      }
    }
  }
}
