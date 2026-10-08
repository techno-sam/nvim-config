-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = "\\"
vim.g.maplocalleader = ";"

-- TODO: refactor to only set vim.opt and such things
require("config.opts")

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.langs" },
  },
  install = { colorscheme = { "catppuccin", "habamax" } },
  rocks = { enabled = false },
  checker = { enabled = false },
  performance = { rtp = { paths = { "/usr/lib/x86_64-linux-gnu/nvim" } } },
})

require("config.keys")
