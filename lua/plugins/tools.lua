return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        git_ignored = false,
      },
    },
  },

  { "preservim/tagbar" },

  { "voldikss/vim-floaterm" },

  { "folke/trouble.nvim", opts = {} },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "SAFETY" } },
        PERF = { icon = "󰅒 ", color = "optim", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      colors = {
        optim = { "Info", "#C11BE6" },
      },
    },
  },
  -- TODO: demo
  -- HACK: demo
  -- WARN: demo
  -- PERF: demo
  -- NOTE: demo
  -- TEST: demo
}
