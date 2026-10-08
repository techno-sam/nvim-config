vim.lsp.config("clangd", {
  on_attach = function(client, bufnr)
    print("Attached clangd language server")

    --[[FIXME: make this work again
    -- Hover actions
    vim.keymap.set("n", "<C-space>", function() vim.cmd.RustLsp({'hover', 'actions'}) end, { silent = true, buffer = bufnr })
    -- Code action groups
    vim.keymap.set("n", "<Leader>a", function() vim.cmd.RustLsp('codeAction') end, { silent = true, buffer = bufnr })
    ]]
  end,
  settings = {
    clangd = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true
      },
      fallbackFlags = { "-std=c++20" }
    }
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  cmd = { 'clangd-18' }
})
