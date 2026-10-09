-- Functional wrapper for mapping custom keybindings
-- mode (as in Vim modes like Normal/Insert mode)
-- lhs (the custom keybinds you need)
-- rhs (the commands or existing keybinds to customise)
-- opts (additional options like <silent>/<noremap>, see :h map-arguments for more info on it)
local function map(mode, lhs, rhs, opts)
    local options = { remap = false }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- window management
map('n', '<leader>v', "<C-w>v", { desc = "Split Vert" })
map('n', '<leader>h', "<C-w>s", { desc = "Split Horz" })
map('n', '<leader>se', "<C-w>=", { desc = "Make Splits Equal Width & Height" })
map('n', '<leader>xs', ":close<CR>", { desc = "Close Split" })

-- better indenting
map('v', '<', "<gv")
map('v', '>', ">gv")

-- navigate between splits
map('n', '<C-k>', ":wincmd k<CR>")
map('n', '<C-j>', ":wincmd j<CR>")
map('n', '<C-h>', ":wincmd h<CR>")
map('n', '<C-l>', ":wincmd l<CR>")

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  --map("n", "<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
end

map("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })
map("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
--map("n", "<leader>gl", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, { desc = "Git Log" })
map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
map({"n", "x" }, "<leader>gY", function()
  Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
end, { desc = "Git Browse (copy)" })

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
end, { desc = "Toggle Spellcheck" })
vim.keymap.set('n', '<leader>ll', function()
    spell_lang = (spell_lang % #spell_langs) + 1
    vim.api.nvim_set_option_value("spell", true, {scope="local"})
    vim.api.nvim_set_option_value("spelllang", spell_langs[spell_lang], {scope="local"})
    print(spell_status())
end, { desc = "Cycle Language" })
map('i', "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Correct Spelling" })

-- format code
vim.keymap.set({'n','v'}, '<leader>pf', function()
    vim.lsp.buf.format()
end, {desc="Format buffer"})
