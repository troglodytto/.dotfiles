" Basic Setup
set number relativenumber
set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
colorscheme delek 
set background=light
set encoding=UTF-8

call plug#begin()

if has('nvim')
  Plug 'preservim/nerdtree'
  Plug 'mhinz/vim-crates'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'rust-lang/rust.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-fugitive'
  Plug 'cespare/vim-toml'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'tasn/vim-tsx'
  Plug 'ryanoasis/vim-devicons'
  Plug 'elixir-editors/vim-elixir'
endif

call plug#end()

if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif

" Custom Highlight
highlight Todo ctermfg=Yellow cterm=Bold ctermbg=None
highlight link Crates WarningMsg

" Airline Setup
let g:airline_powerline_fonts=1
let g:airline_theme='papercolor'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1

" Custom Keymaps
nmap <leader>n :NERDTreeFocus<CR>
nmap <C-n> :NERDTree<CR>
nmap <C-t> :NERDTreeToggle<CR>
nmap <C-m> :CratesUp<CR>
nmap <C-l> :FZF<CR>

" Rust
let g:rustfmt_autosave=1

" Typescript/JavaScript
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Go
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
