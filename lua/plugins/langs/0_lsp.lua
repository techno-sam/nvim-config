return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "glsl_analyzer",
        "jdtls",
        "lua_ls",
        "texlab",
        "wgsl_analyzer",
        "slangd",

        "html",
        "cssls",
        "cssmodules_ls",
        "css_variables",
        "intelephense",
      },
    },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      })

      -- set up language-specific configs
      local configs_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'plugins', 'langs', 'configs')
      for file_name, type in vim.fs.dir(configs_dir, { follow = true }) do
        if (type == 'file' or type == 'link') and file_name:match '%.lua$' then
          local module = file_name:gsub('%.lua$', '')
          require('plugins.langs.configs.' .. module)
        end
      end

      vim.lsp.enable({
        --"rust_analyzer", -- handled by rustaceanvim
        "glsl_analyzer",
        "clangd",
        "pylsp",
        "jdtls",
        "hls",
        "erlangls",

        "html",
        "cssls",
        "cssmodules_ls",
        "css_variables",
        "intelephense",

        "qml-language-server",

        "postgres_lsp"
      })

      -- LSP Diagnostics Options Setup
      local sign = function(opts)
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = ''
        })
      end

      sign({ name = 'DiagnosticSignError', text = '' })
      sign({ name = 'DiagnosticSignWarn', text = '' })
      sign({ name = 'DiagnosticSignHint', text = '󰌶' })
      sign({ name = 'DiagnosticSignInfo', text = '' })

      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        update_in_insert = true,
        underline = true,
        severity_sort = false,
        float = {
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })

      vim.cmd([[
      set signcolumn=yes
      autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
      ]])
    end,
  }
}
