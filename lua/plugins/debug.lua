return {
  {
    "puremourning/vimspector",
    --lazy = false,
    event = "VeryLazy",
    init = function()
      vim.g.vimspector_sidebar_width = 85
      vim.g.vimspector_bottombar_height = 15
      vim.g.vimspector_terminal_maxwidth = 70
    end,
    keys = {
      { "<leader>dL", "<cmd>call vimspector#Launch()<cr>", desc = "Launch Vimspector" },
      { "<leader>dR", "<cmd>call vimspector#Reset()<cr>", desc = "Reset" },

      { "<leader>db", "<cmd>call vimspector#ToggleBreakpoint()<cr>", desc = "Toggle Breakpoint" },

      { "<leader>dw", "<cmd>call vimspector#AddWatch()<cr>", desc = "Add Watch" },
      { "<leader>de", "<cmd>call vimspector#Evaluate()<cr>", desc = "Evaluate Expression" },

      { "<leader>di", "<cmd>call vimspector#StepInto()<cr>", desc = "Step Into" },
      { "<leader>do", "<cmd>call vimspector#StepOut()<cr>", desc = "Step Out" },
      { "<leader>dO", "<cmd>call vimspector#StepOver()<cr>", desc = "Step Over" },
    },
  },
}
