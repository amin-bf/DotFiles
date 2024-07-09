local cmp = require "cmp"

local function border(hl_name)
  return {{"╭", hl_name}, {"─", hl_name}, {"╮", hl_name}, {"│", hl_name}, {"╯", hl_name}, {"─", hl_name},
          {"╰", hl_name}, {"│", hl_name}}
end

local options = {
  completion = {
    completeopt = "menu,menuone"
  },

  window = {
    completion = {
      side_padding = 1,
      -- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
      scrollbar = false,
      border = border "CmpBorder"
    },
    documentation = {
      border = border "CmpDocBorder",
      winhighlight = "Normal:CmpDoc"
    }
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  formatting = {
    fields = {"kind", "abbr", "menu"},
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({
        mode = "symbol_text",
        maxwidth = 50
      })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", {
        trimempty = true
      })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "    (" .. (strings[2] or "") .. ")"

      return kind
    end
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {"i", "s"}),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {"i", "s"})
  },
  sources = {{
    name = "nvim_lsp"
  }, {
    name = "luasnip"
  }, {
    name = "buffer"
  }, {
    name = "nvim_lua"
  }, {
    name = "path"
  }}
}

return {
  init = function()
    require("cmp").setup(options)
  end,
  initLuaSnip = function()
    require("luasnip").config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI"
    })

    -- vscode format
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load {
      paths = vim.g.vscode_snippets_path or ""
    }

    vim.api.nvim_create_autocmd("InsertLeave", {
      callback = function()
        if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()] and
          not require("luasnip").session.jump_active then
          require("luasnip").unlink_current()
        end
      end
    })
  end,
  initAutopair = function()
    require("nvim-autopairs").setup({
      fast_wrap = {},
      disable_filetype = {"TelescopePrompt", "vim"}

    })

    -- setup cmp for autopairs
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
}
