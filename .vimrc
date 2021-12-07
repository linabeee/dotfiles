set nocompatible

set autoindent
set autoread
set backspace=indent,eol,start
set complete-=i
set display=lastline
set encoding=utf-8
set history=10000
set incsearch
set langnoremap
set smarttab
set ttyfast
set viminfo='0,h,n~/.cache/viminfo
set wildmenu
set laststatus=1
set expandtab
set nohlsearch
set hidden
set background=dark
set splitright
set splitbelow
set wrap
set linebreak
set modeline
set clipboard+=unnamedplus
set signcolumn=no
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set mouse=a
set scrolloff=1

silent! colorscheme dim
if has('gui')
  set guioptions-=m
  set guioptions-=T
  set guioptions+=c
  highlight Normal guibg=black guifg=white
endif

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <F1> <Nop>
nnoremap q <Nop>
nnoremap [b :bprev<CR>
nnoremap ]b :bnext<CR>
cnoremap <C-g> <C-c>
tnoremap <Esc> <C-\><C-n>

autocmd FileType * setl sts=4 sw=4
autocmd FileType vim setlocal sts=2 sw=2
autocmd FileType go setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_fixers = {
  \'*': ['remove_trailing_lines', 'trim_whitespace'],
  \'rust': ['rustfmt'],
  \'haskell': ['ormolu'],
  \'python': ['black'],
  \'nix': ['nixpkgs-fmt'],
  \'go': ['gofmt'],
  \'javascript': ['prettier']
  \}

let g:buftabline_show = 1
let g:buftabline_indicators = 1
let g:buftabline_numbers = 1
