set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"
inoremap <silent><expr> <c-space> coc#refresh()
tnoremap <Esc> <C-\><C-n>
nmap <F2> <Plug>(coc-rename)

set background=dark
silent! colorscheme base16-monokai

function! Terminal()
  botright new
  terminal
  startinsert!
endfunction

command! Terminal call Terminal()

autocmd TermOpen * setlocal wrap
