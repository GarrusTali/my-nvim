inoremap jk <ESC>
nnoremap <Space> <Nop>
let mapleader="\<Space>"

set encoding=utf-8
set tabstop=4 shiftwidth=4 expandtab

call plug#begin('~/.local/share/nvim/plugged')

" theme-cake
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'

" controller-jet
Plug 'Shougo/denite.nvim'

" typing-candy
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'

" programming-rock
" utils-accel
call plug#end()


" <===== theme-cake
set termguicolors
syntax on
colorscheme onedark
let g:airline_theme='onedark'

set number
" =====> theme-cake


" <===== leader key-map
" ==Windows -- <Leader> + w
" split
nnoremap <Leader>wn <C-w>v
nnoremap <Leader>wv <C-w>s

nnoremap <Leader>wfn :vsplit 
nnoremap <Leader>wfv :split 

nnoremap <Leader>wsn :vnew<CR>
nnoremap <Leader>wsv :new<CR>

" navigate
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wl <C-w>l

" move
nnoremap <Leader>wH <C-w>H
nnoremap <Leader>wJ <C-w>J
nnoremap <Leader>wK <C-w>K
nnoremap <Leader>wL <C-w>L

" close
nnoremap <Leader>wx <C-w>c

" ==Quit -- <Leader> + q
nnoremap <Leader>qs :wqall<CR>
nnoremap <Leader>qq :qall<CR>
nnoremap <Leader>qQ :qall!<CR>

" =====> leader key-map
