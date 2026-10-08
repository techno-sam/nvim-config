return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      color_icons = true,
      default = true,
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- auto, latte, frappe, macchiato, mocha
        auto_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          hop = true,
          illuminate = true,
          indent_blankline = true,
          mason = true,
          nvimtree = true,
          render_markdown = true,
          snacks = true,
          telescope = true,
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        disabled_filetypes = {
          "statusline",
          "winbar",
          "NvimTree",
        },
        globalstatus = true, -- single bar across bottom of window
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "lsp_status", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
}
