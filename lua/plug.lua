return require('packer').startup(function()
    -- other plugins...
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Rusty stuffsy
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'

    -- Completion framework:
    use 'hrsh7th/nvim-cmp'

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'
    
    -- More LSP for C++
    use 'p00f/clangd_extensions.nvim'

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
    use 'RRethy/vim-illuminate'
    use 'folke/trouble.nvim'
    use 'folke/todo-comments.nvim'
    use 'preservim/tagbar'
    use 'nvim-tree/nvim-tree.lua'
    use { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} }
    use 'm-demare/hlargs.nvim'
end)

