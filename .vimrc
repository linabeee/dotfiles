set nocompatible

silent! if plug#begin()
Plug 'Vimjas/vim-python-pep8-indent', {'for': ['py']}
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
Plug 'LnL7/vim-nix', {'for': ['nix']}
if has('nvim')
Plug 'chriskempson/base16-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
endif
call plug#end()
else
  if has('autocmd')
    filetype plugin indent on
  endif
  if has('syntax')
    syntax enable
  endif
endif

set autoindent
set autoread
set backspace=indent,eol,start
set complete-=i
set display=lastline
set encoding=utf-8
set formatoptions=tcqj
set history=10000
set incsearch
set langnoremap
set listchars=tab:>\ ,trail:-,nbsp:+
set nrformats=hex
set sessionoptions-=options
set smarttab
set tabpagemax=50
set tags=./tags;,tags
set ttyfast
set viminfo=
set wildmenu
set softtabstop=4
set shiftwidth=4
set expandtab
set nohlsearch
set hidden
set background=light
set splitright
set splitbelow
set wrap
set linebreak
" set termguicolors
set modeline
set laststatus=1
set clipboard+=unnamedplus
set signcolumn=no
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set cmdheight=2
set mouse=a

let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \'rust': ['rustfmt'],
  \'haskell': ['ormolu'],
  \'python': ['black'],
  \'nix': ['nixfmt'],
  \'go': ['gofmt']
  \}
let g:ale_linters = {
  \'python': ['pyflakes']
  \}
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_disable_lsp = 1

autocmd FileType python setlocal softtabstop=4 shiftwidth=4
autocmd FileType vim setlocal sts=2 sw=2
autocmd BufWritePre * :%s/\s\+$//e

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <F1> <Nop>
nnoremap q <Nop>
