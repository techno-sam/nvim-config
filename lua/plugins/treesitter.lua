return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = { "mason.nvim" },
    config = function()
      local ts = require("nvim-treesitter")
      local langs = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "rust",
        "toml",
      }

      ts.setup({})

      ts.install(langs)

      -- treesitter autocommands from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        -- Check if the buffer is valid (might not be after install completes)
        if not vim.api.nvim_buf_is_valid(buf) then return end

        -- Check if a parser exists and load it
        if not vim.treesitter.language.add(language) then return end

        -- Enable syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- Enable treesitter based folds
        -- For more info on folds see `:help folds`
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'

        -- Check if treesitter indentation is available for this language, and if so enable it
        -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
        local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

        -- Enable treesitter based indentation
        if has_indent_query then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      local available_parsers = ts.get_available()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end

          local installed_parsers = ts.get_installed 'parsers'

          if vim.tbl_contains(installed_parsers, language) then
            -- Enable the parser if it is already installed
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
            local yesno = vim.fn.input(language .. " parser can be installed: would you like to install ? y/n: ")
            if string.match(yesno, "^y.*") then
              ts.install(language):await(function()
                treesitter_try_attach(buf, language)
              end)
            end
          else
            -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
            treesitter_try_attach(buf, language)
          end
        end
      })

      --[[vim.api.nvim_create_autocmd("FileType", {
        pattern = langs,
        callback = function()
          -- native nvim treesitter highlighting
          vim.treesitter.start()

          -- code folding
          -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          -- vim.wo.foldmethod = "expr"
          -- vim.wo.foldlevel = 99

          -- ts-indent
          -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })--]]
    end,
  },
}
