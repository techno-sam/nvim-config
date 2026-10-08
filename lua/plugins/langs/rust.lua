return {
  {
    "mrcjkb/rustaceanvim",
    dependencies = { "vxpm/ferris.nvim" },
    version = "^9",
    -- plugin implements lazy loading itself
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        on_attach = function(_, bufnr)
          print("Attached rust language server")
          -- Hover actions
          vim.keymap.set("n", "<C-space>", function() vim.cmd.RustLsp({ 'hover', 'actions' }) end,
            { silent = true, buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", function() vim.cmd.RustLsp('codeAction') end,
            { silent = true, buffer = bufnr })


          local view_mem_layout = require("ferris.methods.view_memory_layout")
          vim.keymap.set("n", "M", function() view_mem_layout() end, { silent = true, buffer = bufnr })
        end,
        --[[settings = { -- disable for non-base-os projects
      ["rust-analyzer"] = {
        check = {
          allTargets = false,
          extraArgs = {"--target", "base_os.json"}
        }
      }
    },--]]
      }

      -- TODO: check if this is still necessary. Disabled for now

      --[[
      -- temporary fix for rust analyzer cancelling requests and NVIM not supporting it
      for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
        local default_diagnostic_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, result, context, config)
          if err ~= nil and err.code == -32802 then
            return
          end
          return default_diagnostic_handler(err, result, context, config)
        end
      end--]]
    end,
  },

  {
    -- for the memory layout view
    "vxpm/ferris.nvim"
  },
}
