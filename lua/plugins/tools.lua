return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        git_ignored = false,
      },
    },
    cmd = { "NvimTreeToggle", "NvimTreeOpen" },
    keys = {
      { ",", ":NvimTreeToggle<CR>", desc = "Toggle Tree View" },
    },
  },

  {
    "preservim/tagbar",
    keys = {
      { "<F8>", ":TagbarToggle<CR>", desc = "Toggle Tagbar" },
    },
  },

  {
    "voldikss/vim-floaterm",
    keys = {
      {
        "<leader>ft",
        ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=smart<CR>",
        desc = "New Floaterm",
      },
      {
        "t",
        ":FloatermToggle myfloat<CR>",
        desc = "Toggle Floaterm",
      },
      {
        "<Esc>",
        "<C-\\><C-n>:q<CR>",
        mode = "t",
        desc = "Close Floaterm",
      },
    },
  },

  { "folke/trouble.nvim", opts = {} },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- TO-DO: demo
      -- HA-CK: demo
      -- WA-RN: demo
      -- PE-RF: demo
      -- NO-TE: demo
      -- TE-ST: demo
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

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    ---@class wk.Opts
    opts = {
      preset = "helix",
      spec = {
        {
          mode = { "n", "x" },
          { "<leader>f", group = "file/find" },
          { "<leader>d", group = "debug" },
          { "<leader>rm", group = "render md" },
          { "<leader>l", group = "spelling" },
          { "<leader>g", group = "git" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },

      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
  }
}
