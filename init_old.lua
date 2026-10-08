-- Treesitter Plugin Setup 
--[[
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    disable = {"latex"},
    additional_vim_regex_highlighting =  {"php"},
  },
  ident = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
} --]]


require('keys')
