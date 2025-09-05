local theme = "catppuccin" -- monokai or catppuccin

local first_install = os.getenv("VI_FIRST_INSTALL") == "1"
if first_install then
  require('plug')
  return
end

-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      print("Attached rust language server")
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    --[[settings = { -- disable for non-base-os projects
      ["rust-analyzer"] = {
        check = {
          allTargets = false,
          extraArgs = {"--target", "base_os.json"}
        }
      }
    },--]]
  },
})

require("inlay-hints").setup({
  commands = { enable = true }, -- Enable InlayHints commands, include `InlayHintsToggle`, `InlayHintsEnable` and `InlayHintsDisable`
  autocmd = { enable = false } -- Enable the inlay hints on `LspAttach` event
})

require("clangd_extensions").setup {
--[[  inlay_hints = {
    inline = false
  }--]]
}

local lspconfig = require"lspconfig"

--lspconfig.wgsl_analyzer.setup{}
--lspconfig.glasgow.setup{} -- wgsl analyzer, but functional
lspconfig.glsl_analyzer.setup{}
lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    print("Attached clangd language server")
    require("inlay-hints").on_attach(client, bufnr)
    
    -- Hover actions
    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
    -- Code action groups
    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
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
}
lspconfig.pylsp.setup {
--on_attach = custom_attach,
settings = {
    pylsp = {
    plugins = {
        -- formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
    },
    },
},
flags = {
    debounce_text_changes = 200,
},
--capabilities = capabilities,
}

lspconfig.jdtls.setup {}


-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = '󰌶'})
sign({name = 'DiagnosticSignInfo', text = ''})

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

-- Completion Plugin Setup
local luasnip = require'luasnip'
local ls_types = require("luasnip.util.types")
luasnip.setup({
  cut_selection_keys = "<Tab>",
  ext_opts = {
    [ls_types.choiceNode] = {
      active = {
        virt_text = {{"●", "Operator"}},
        virt_text_pos = "inline",
      },
      unvisited = {
        virt_text = {{"●", "Comment"}},
        virt_text_pos = "inline",
      },
    },
    [ls_types.insertNode] = {
      active = {
        virt_text = {{"●", "Keyword"}},
        virt_text_pos = "inline",
      },
      unvisited = {
        virt_text = {{"●", "Comment"}},
        virt_text_pos = "inline",
      },
    },
  }
})

local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {"i", "s"}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {"i", "s"}),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'luasnip', keyword_length = 2 },         -- nvim-cmp source for cmp_luasnip
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              luasnip = '⋗',
              buffer = '',--'Ω',
              path = '',--'🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      -- cmp.config.compare.scopes,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      require("clangd_extensions.cmp_scores"),
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  --[[enabled = function()
    local disabled = false
    disabled = disabled or (vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt')
    disabled = disabled or (vim.fn.reg_recording() ~= '')
    disabled = disabled or (vim.fn.reg_executing() ~= '')
    disabled = disabled or require('cmp.config.context').in_treesitter_capture('comment')
    return not disabled
  end,]]
})

-- Treesitter Plugin Setup 
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

-- Hop plugin setup
require("hop").setup()

-- Devicons setup
require("nvim-web-devicons").setup({
	color_icons = true;
	default = true;
})


if theme == "monokai" then
-- INFO: monokai theme setup

--local mk_palette = require('monokai').classic
require('monokai').setup {
--	palette = mk_palette,
	--[[custom_hlgroups = {
		["@function.call"] = { fg = mk_palette.green, style = 'italic' },
		["@text.todo"]     = { fg = mk_palette.orange, style = 'bold' },
		["@todo"]          = { fg = mk_palette.orange, style = 'bold' },
		["@include"]       = { fg = mk_palette.pink, style = 'italic' },
		["@define"]        = { fg = mk_palette.pink, style = 'italic' },
		["@preproc"]       = { fg = mk_palette.pink, style = 'bold' }
	},--]]
}
elseif theme == "catppuccin" then
-- INFO: catppuccin theme setup
require("catppuccin").setup({
    flavour = "mocha", -- auto, latte, frappe, macchiato, mocha
})
vim.cmd.colorscheme "catppuccin"
end

-- vim-illuminate setup
-- default configuration
require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        'dirvish',
        'fugitive',
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    -- See `:help mode()` for possible values
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
    -- See `:help mode()` for possible values
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
    -- large_file_cutoff: number of lines at which to use large_file_config
    -- The `under_cursor` option is disabled when this cutoff is hit
    large_file_cutoff = nil,
    -- large_file_config: config to use for large files (based on large_file_cutoff).
    -- Supports the same keys passed to .configure
    -- If nil, vim-illuminate will be disabled for large files.
    large_file_overrides = nil,
    -- min_count_to_highlight: minimum number of matches required to perform highlighting
    min_count_to_highlight = 1,
})

-- trouble setup
require("trouble").setup()

-- todo-comments setup
require("todo-comments").setup({
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = "󰅒 ", color = "optim", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  },
  colors = {
    optim = {"Info", "#C11BE6"}
  }
})
-- TODO: demo
-- HACK: demo
-- WARN: demo
-- PERF: demo
-- NOTE: demo
-- TEST: demo

-- nvim-tree setup
require("nvim-tree").setup({
  filters = {
    git_ignored = false
  }
})

-- hlargs setup
require("hlargs").setup()

-- indent blankline setup
require("ibl").setup {
    scope = {
        enabled = true,
        show_start = true,
        show_exact_scope = true,
        char = "▏",
        highlight = { "Label", "IblScope" },
    }
}

-- conjure
vim.g["conjure#filetypes"] = {
  "clojure",
  "fennel",
  "janet",
  "hy",
  "julia",
  "racket",
  "scheme",
  --"lua",
  "lisp",
  --"python",
  --"rust",
  "sql",
}
--vim.g["conjure#log#level"] = "debug"

-- listchars
vim.opt.list = true
vim.opt.listchars:append "space:⋅"

--[[vim.schedule_wrap(function()
	print("nope")
	print("other")
end)()--]]

-- temporary fix for rust analyzer cancelling requests and NVIM not supporting it
for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

-- setup other lua files
require('vars')
require('opts')
require('keys')
require('plug')
