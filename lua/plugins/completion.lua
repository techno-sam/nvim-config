return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    -- dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")
      local ls_types = require("luasnip.util.types")
      luasnip.setup({
        cut_selection_keys = "<Tab>",
        ext_opts = {
          [ls_types.choiceNode] = {
            active = { virt_text = { { "●", "Operator" } } },
          },
          [ls_types.insertNode] = {
            active = { virt_text = { { "●", "Keyword" } } },
          },
        },
      })
      vim.cmd([[
      imap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
      smap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
      ]])
      --require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/snippets" } })
      require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/snippets" } })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "p00f/clangd_extensions.nvim", -- cmp_scores comparator
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        -- Enable LSP snippets
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Add tab support
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = true,
                })
              else
                cmp.select_next_item()
              end
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            elseif luasnip.expandable() then
              if not luasnip.expand({}) then
                fallback()
              end
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          })
        },
        -- Installed sources:
        sources = {
          { name = 'path' }, -- file paths
          { name = 'nvim_lsp', keyword_length = 3 }, -- from language server
          { name = 'nvim_lsp_signature_help' }, -- display function signatures with current parameter emphasized
          { name = 'nvim_lua', keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
          { name = 'buffer', keyword_length = 2 }, -- source current buffer
          { name = 'luasnip', keyword_length = 2 }, -- nvim-cmp source for cmp_luasnip
          { name = 'calc' }, -- source for math calculation
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { 'menu', 'abbr', 'kind' },
          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = 'λ',
              luasnip = '⋗',
              buffer = '', --'Ω',
              path = '', --'🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            -- cmp.config.compare.scopes,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require("clangd_extensions.cmp_scores"),
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        --[[enabled = function()
    local disabled = false
    disabled = disabled or (vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt')
    disabled = disabled or (vim.fn.reg_recording() ~= '')
    disabled = disabled or (vim.fn.reg_executing() ~= '')
    disabled = disabled or require('cmp.config.context').in_treesitter_capture('comment')
    return not disabled
  end,]]
      })
    end,
  },
}
