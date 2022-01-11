set nocompatible

let g:polyglot_disabled = ['sensible', 'autoindent']
packadd vim-polyglot

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
set laststatus=2
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
set showcmd
set cmdheight=2
silent! set ttymouse=xterm2

silent! colorscheme dim
if has('gui')
  set guioptions-=m
  set guioptions-=T
  set guioptions+=c
  highlight Normal guibg=black guifg=white
endif

noremap j gj
noremap k gk
noremap <F1> <Nop>
nnoremap q <Nop>
nnoremap [b :bprev<CR>
nnoremap ]b :bnext<CR>
cnoremap <C-g> <C-c>
tnoremap <Esc> <C-\><C-n>

autocmd FileType * setl sts=2 sw=2
autocmd FileType go setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8
autocmd FileType html inoremap </ </<C-X><C-O>

let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

let g:bufferline_echo = 0
packadd vim-bufferline
let &statusline='%<%{bufferline#refresh_status()}'.bufferline#get_status_string().'%h%r%=%-14.(%l,%c%)%P'

let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {'perl': ['perl', 'perlcritic']}
let g:ale_fixers = {
  \'rust': ['rustfmt'],
  \'haskell': ['ormolu'],
  \'python': ['black'],
  \'nix': ['nixpkgs-fmt', 'nixfmt'],
  \'go': ['gofmt'],
  \'javascript': ['prettier'],
  \'javascriptreact': ['prettier'],
  \'perl': ['perltidy']
  \}
