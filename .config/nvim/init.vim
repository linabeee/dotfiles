silent! if plug#begin()
Plug 'Vimjas/vim-python-pep8-indent', {'for': ['py']}
Plug 'chriskempson/base16-vim'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
Plug 'peterhoeg/vim-qml', {'for': ['qml']}
Plug 'ziglang/zig.vim', {'for': ['zig']}
Plug 'zah/nim.vim', {'for': ['nim']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'LnL7/vim-nix', {'for': ['nix']}
call plug#end()
endif

set softtabstop=4
set shiftwidth=4
set expandtab
set nohlsearch
set hidden
set autoread
set background=dark
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
if $SHELL =~ "fish"
  set shell=/bin/sh
endif

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
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"
inoremap <silent><expr> <c-space> coc#refresh()
tnoremap <Esc> <C-\><C-n>
nmap <F2> <Plug>(coc-rename)

silent! colorscheme base16-monokai

function! Terminal()
  botright new
  terminal
  startinsert!
endfunction

command! Terminal call Terminal()

autocmd TermOpen * setlocal wrap

