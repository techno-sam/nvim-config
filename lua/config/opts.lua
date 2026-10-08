-- vim.{o,wo,bo} are preferred for simple options
-- for complex options (e.g. those involving lists) use vim.opt

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.o.updatetime = 300

-- we have lualine, no need to separately show mode
vim.o.showmode = false

-- listchars
vim.o.list = true
vim.opt.listchars:append "space:⋅"

-- line numbers
vim.wo.number = true -- absolute number on current line
vim.wo.relativenumber = true -- relative numbers on other lines

vim.o.winborder = 'rounded'

-- Quadlet Filetypes
vim.filetype.add({
  extension = {
    container = "systemd",
    network = "systemd"
  }
})

-- highlight trailing whitespace
vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    -- avoid duplicates
    if vim.w.trailing_whitespace_match then return end

    vim.w.trailing_whitespace_match = vim.fn.matchadd(
      "ErrorMsg",
        [[\s\+$]]
    )
  end
})

-- colorcolumn at textwidth
vim.opt.colorcolumn:append("+0")

--[[
Indentation setup:
  tabstop:          Width of tab character (i.e. ASCII-9)
  softtabstop:      Number of columns <Tab> and <BS> add/remove in insert mode.
  shiftwidth        Number of columns in one level of (auto)indentation. Normal mode: <<, >>
  expandtab:        If enabled, use spaces instead of tabs
--]]

-- default: 4-space indents
vim.o.tabstop     = 4
vim.o.softtabstop = 4
vim.o.shiftwidth  = 4
vim.o.expandtab   = true

-- customize indents for particular file types
-- projects should use a .editorconfig to overwrite these

local indents = {
  {
    ft = { "glsl", "javascript", "cpp", "java", "php" },
    spaces = 4,
  },

  {
    ft = { "json", "lua", "haskell", "lhaskell", "nix", "qml" },
    spaces = 2,
  },

  {
    ft = { "c", "h", "python" },
    spaces = 4,
    extra = { textwidth = 100 },
  },
}

for _, cfg in ipairs(indents) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = cfg.ft,
    callback = function(_)
      local width = cfg.spaces or cfg.tab_width
      vim.bo.tabstop = width
      vim.bo.softtabstop = width
      vim.bo.shiftwidth = width
      vim.bo.expandtab = cfg.spaces ~= nil

      if cfg.extra ~= nil then
        for k, v in pairs(cfg.extra) do
          vim.bo[k] = v
        end
      end
    end
  })
end

-- C++ setup (https://stackoverflow.com/a/3458218)
--vim.cmd([[
--set nocp
--filetype plugin on
--map <C-L> :!ctags -R --c++-kinds=+p --fields=+iaS --extras=+q .<CR><CR>
--
--set tags=~/.nvim_ctags/stdtags,tags,.tags,../tags
--
--autocmd InsertLeave * if pumvisible() == 0|pclose|endif
--]])
