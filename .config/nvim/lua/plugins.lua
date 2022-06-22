return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'rhysd/vim-grammarous' -- grammar check
    use 'andymass/vim-matchup' -- matching parens and more
    use 'bronson/vim-trailing-whitespace' -- highlight trailing spaces
    use 'scrooloose/nerdcommenter'
    use 'preservim/nerdtree'
    use 'kyazdani42/nvim-web-devicons'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'tpope/vim-fugitive'
    use { 'junegunn/fzf', run = "fzf#install()" }
    use 'ryanoasis/vim-devicons'
    use 'cespare/vim-toml'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'rust-lang/rust.vim'
    use 'simrat39/rust-tools.nvim'
    use 'mfussenegger/nvim-dap'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'folke/tokyonight.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }


    require('rust-tools').setup({
      tools = { -- rust-tools options
        autoSetHints = true,
        executor = require("rust-tools/executors").termopen,
        hover_with_actions = true,
        inlay_hints = {
          show_parameter_hints = true,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
        },
      },

      -- all the opts to send to nvim-lspconfig
      -- these override the defaults set by rust-tools.nvim
      -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
      server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy"
            },
          }
        }
      },
    })

    require('nvim-treesitter.configs').setup({
      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    })

    vim.cmd [[
      sign define DiagnosticSignError text= linehl= texthl=DiagnosticSignError numhl=
      sign define DiagnosticSignWarn text= linehl= texthl=DiagnosticSignWarn numhl=
      sign define DiagnosticSignInfo text= linehl= texthl=DiagnosticSignInfo numhl=
      sign define DiagnosticSignHint text= linehl= texthl=DiagnosticSignHint numhl=
    ]]

    require('autocomplete').setup(
      require('cmp')
    )
  end
})
