return {
  {
    -- TODO: I have to update this
    "techno-sam/inlay-hint.nvim",
    enabled = false,
    opts = { highlight_group = "Comment" },
    config = function(_, opts)
      require("inlay-hint").setup(opts)

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf ---@type number
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client ~= nil and client:supports_method('textDocument/inlayHint', bufnr) then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            vim.keymap.set('n', '<leader>i', function()
              vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                { bufnr = bufnr }
              )
            end, { buffer = bufnr })
          end
        end,
      })
    end
  },

  -- indent guides (fork with inlay-hint compat)
  {
    "techno-sam/indent-blankline.nvim",
    main = "ibl",
    branch = "fix/inlay-hint-compat",
    opts = {
      scope = {
        enabled = true,
        highlight_inlay_hints = false,
        show_start = true,
        show_exact_scope = true,
        char = "▏",
        highlight = { "Label", "IblScope" },
      },
    },
  },

  { "nmac427/guess-indent.nvim", opts = {} },

  { "attilarepka/header.nvim", opts = {} },

  -- more elegant colorcolumn
  { "lukas-reineke/virt-column.nvim", opts = {} },

  { "m-demare/hlargs.nvim", opts = {}, enabled = false },

  {
    "RRethy/vim-illuminate",
    name = "illuminate",
    opts = {
      -- providers: provider used to get references in the buffer, ordered by priority
      providers = { "lsp", "treesitter", "regex" },
      -- delay: delay in milliseconds
      delay = 100,
      filetypes_denylist = { "dirvish", "fugitive" },
      under_cursor = true,
      min_count_to_highlight = 1,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
}
