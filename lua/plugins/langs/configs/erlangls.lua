vim.lsp.config("erlangls", {
  root_markers = {
    'erlang_ls.config',
    'rebar.config',
    'erlang.mk',
    '.git',
  }
})
