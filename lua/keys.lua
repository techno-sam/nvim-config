-- Functional wrapper for mapping custom keybindings
-- mode (as in Vim modes like Normal/Insert mode)
-- lhs (the custom keybinds you need)
-- rhs (the commands or existing keybinds to customise)
-- opts (additional options like <silent>/<noremap>, see :h map-arguments for more info on it)
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.maplocalleader = ";"

-- Vimspector
vim.cmd([[
nmap <F9> <cmd>call vimspector#Launch()<cr>
nmap <F5> <cmd>call vimspector#StepOver()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F11> <cmd>call vimspector#StepOver()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])
map('n', "Db", ":call vimspector#ToggleBreakpoint()<cr>")
map('n', "Dw", ":call vimspector#AddWatch()<cr>")
map('n', "De", ":call vimspector#Evaluate()<cr>")

map('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 fish <CR> ")
map('n', "t", ":FloatermToggle myfloat<CR>")
map('t', "<Esc>", "<C-\\><C-n>:q<CR>")

-- tree view
map('n', ',', ":NvimTreeToggle<CR>")

-- window management
map('n', '<leader>v', "<C-w>v") -- split vert
map('n', '<leader>h', "<C-w>s") -- split horz
map('n', '<leader>se', "<C-w>=") -- make split windows equal width & height
map('n', '<leader>xs', ":close<CR>") -- close current split window

-- better indenting
map('v', '<', "<gv")
map('v', '>', ">gv")

-- navigate btw splits
map('n', '<C-k>', ":wincmd k<CR>")
map('n', '<C-j>', ":wincmd j<CR>")
map('n', '<C-h>', ":wincmd h<CR>")
map('n', '<C-l>', ":wincmd l<CR>")


-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- tagbar
map('n', "<F8>", ":TagbarToggle<CR>")

-- render markdown
map('n', '<leader>rme', ":RenderMarkdown enable<CR>")
map('n', '<leader>rmd', ":RenderMarkdown disable<CR>")
map('n', '<leader>rmt', ":RenderMarkdown toggle<CR>")

-- spelling
local spell_langs = {
    "en,nl",
    "en",
    "nl",
    "nl,en"
}

local spell_lang = 0

local function spell_status()
    local on = vim.api.nvim_get_option_value("spell", {scope="local"})
    local lang = vim.api.nvim_get_option_value("spelllang", {scope="local"})

    local state = on and "on" or "off"

    return "Spellcheck["..lang.."] "..state
end

vim.api.nvim_set_option_value("spelllang", "en,nl", {})
vim.keymap.set('n', '<leader>lt', function()
    vim.cmd("setlocal spell!")
    print(spell_status())
end, {})
vim.keymap.set('n', '<leader>ll', function()
    spell_lang = (spell_lang % #spell_langs) + 1
    vim.api.nvim_set_option_value("spell", true, {scope="local"})
    vim.api.nvim_set_option_value("spelllang", spell_langs[spell_lang], {scope="local"})
    print(spell_status())
end, {})
map('i', "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u")
