--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

vim.o.winborder = 'rounded'

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Quadlet Filetypes
vim.filetype.add({
  extension = {
    container = "systemd",
    network = "systemd"
  }
})

-- Treesitter folding 
--vim.wo.foldmethod = 'expr'
--vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- Vimspector options
vim.cmd([[
let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70
]])

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

-- stolen from brother
vim.wo.number = true -- show line nos
vim.o.relativenumber = true -- better line nos

-- highlight trailing whitespace
vim.cmd([[
match errorMsg /\s\+$/
]])

-- Default indent setup
vim.cmd([[
" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
]])


-- Indentation setup
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "glsl", "javascript", "cpp", "java" },
  callback = function(args)
    vim.cmd([[
" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
    ]])
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "json", "lua", "haskell", "lhaskell" },
  callback = function(args)
    vim.cmd([[
" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =2
set softtabstop =2
set shiftwidth  =2
set expandtab
    ]])
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "groovy" },
  callback = function(args)
    vim.cmd([[
" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab!
    ]])
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "c", "h" },
  callback = function(args)
    vim.cmd([[
" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set textwidth   =100
set colorcolumn =+0
    ]])
    require("virt-column").setup{}
  end
})
