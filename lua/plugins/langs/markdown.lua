return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    ft = "markdown",
    opts = {},
    keys = {
      { "<leader>rme", ":RenderMarkdown enable<CR>", desc = "Enable Markdown" },
      { "<leader>rmd", ":RenderMarkdown disable<CR>", desc = "Disable Markdown" },
      { "<leader>rmt", ":RenderMarkdown toggle<CR>", desc = "Toggle Markdown" },
    },
  },
}
