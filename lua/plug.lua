return require('packer').startup(function()
    -- other plugins...
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Rusty stuffsy
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    use 'neovim/nvim-lspconfig'
    use 'mrcjkb/rustaceanvim'

    -- Completion framework:
    use 'hrsh7th/nvim-cmp'

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use { 'saadparwaiz1/cmp_luasnip' }
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use {
        'L3MON4D3/LuaSnip',
        tag = 'v2.*',
        run = "make install_jsregexp",
    }
    --use 'rafamadriz/friendly-snippets'

    -- nvim config dev
    use {
        'folke/lazydev.nvim',
        config = function()
            require("lazydev").setup()
        end,
    }

    -- More LSP for C++
    use 'p00f/clangd_extensions.nvim'

    -- inlay hints
    use 'felpafel/inlay-hint.nvim'

    -- automatic indent detection
    use {
      'nmac427/guess-indent.nvim',
      config = function() require('guess-indent').setup {} end,
    }

    use 'nvim-treesitter/nvim-treesitter'

    use 'puremourning/vimspector'

    use 'voldikss/vim-floaterm'
    
    -- searching
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'phaazon/hop.nvim'

    -- nice stuff
    use 'nvim-tree/nvim-web-devicons'
    use 'tanvirtin/monokai.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'RRethy/vim-illuminate'
    use 'folke/trouble.nvim'
    use 'folke/todo-comments.nvim'
    use 'preservim/tagbar'
    use 'nvim-tree/nvim-tree.lua'
    use { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} }
    use 'm-demare/hlargs.nvim'

    -- markdown
    use {
      'MeanderingProgrammer/render-markdown.nvim',
      after = { 'nvim-treesitter' },
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
      config = function()
        require('render-markdown').setup({})
      end
    }

    -- scheme!
    use 'Olical/conjure'

    -- caddy
    use 'isobit/vim-caddyfile'

    -- headers
    use { "attilarepka/header.nvim", config = function() require("header").setup() end }

    -- more elegant colorcolumn
    use { 'lukas-reineke/virt-column.nvim', config = function() require("virt-column").setup{} end }

    -- git
    use { 'lewis6991/gitsigns.nvim', config = function() require("gitsigns").setup() end }

    -- latex
    use { 'lervag/vimtex', tag = "v2.*", }
end)

