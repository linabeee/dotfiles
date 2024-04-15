set nocompatible

filetype plugin indent on
syntax on

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
set viminfo='0,h ",n~/.cache/viminfo
set wildmenu
set laststatus=1
set expandtab
set nohlsearch
set nohidden
set background=dark
set splitright
set splitbelow
set wrap
set linebreak
set modeline
" set clipboard+=unnamedplus
set signcolumn=no
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set mouse=a
set scrolloff=1
set showcmd
set cmdheight=2
set completeopt=menu,menuone,noselect
set expandtab
set softtabstop=2
set shiftwidth=2
set ruler
set noswapfile
silent! set ttymouse=xterm2

silent! colorscheme dim
if has('gui_running')
  set guioptions-=m
  set guioptions-=T
  set guioptions+=c
  set bg=light
  set guifont=Menlo:h12
  let g:gruvbox_contrast_light = 'hard'
  silent! colorscheme gruvbox
endif

noremap j gj
noremap k gk
noremap <F1> <Nop>
nnoremap q <Nop>
nnoremap [b :bprev<CR>
nnoremap ]b :bnext<CR>
cnoremap <C-g> <C-c>
silent! tnoremap <Esc> <C-\><C-n>

augroup Lina
  autocmd!
augroup END

let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
