inoremap jk <ESC>
nnoremap <Space> <Nop>
let g:mapleader = "\<Space>"

" <===== Options
set viewoptions=folds,options,cursor,unix,slash
set encoding=utf-8
set tabstop=4 shiftwidth=4 expandtab smarttab
set autoindent
set smartindent
set shiftround
set nospell

set lazyredraw
set laststatus=2
set noshowmode
set showcmd
set number
set relativenumber
set cursorline
set display+=lastline

set termguicolors
syntax on

set hidden
set autoread
set splitright
set splitbelow

set gdefault
set ignorecase
set smartcase
set hlsearch
set incsearch

set infercase
set complete-=i
set complete+=kspell
set completeopt=menuone,noselect,noinsert

" Disable built-in plugins
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1

let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_zip = 1
let g:loaded_vimball = 1
let g:loaded_tarPlugin = 1
let g:loaded_zipPlugin = 1
let g:loaded_vimballPlugin = 1

let g:loaded_netrw = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_rrhelper = 1

let g:python3_host_prog = '/usr/bin/python3'
" =====> Options

" Install vimplug if not exists
if empty(glob('$HOME/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup install
    autocmd!
    autocmd VimEnter * PlugInstall | source $MYVIMRC
    augroup end " install
endif

call plug#begin('~/.local/share/nvim/plugged')

" theme-cake
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
Plug 'joshdick/onedark.vim'

" controller-jet
Plug 'Shougo/denite.nvim',   {'do': ':UpdateRemotePlugins'}
Plug 'Shougo/neomru.vim'

" typing-candy
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'

" programming-rock
Plug 'Shougo/deoplete.nvim',   {'do': ':UpdateRemotePlugins'}
Plug 'Shougo/neco-vim'
Plug 'zchee/deoplete-jedi'
Plug 'racer-rust/vim-racer'

Plug 'w0rp/ale'

Plug 'rust-lang/rust.vim'

" utils-accel
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-repeat'

call plug#end()


" <===== theme-cake
colorscheme onedark

" lightline
let g:responsive_width_mid = 70
let g:responsive_width_small = 50
let g:omit_fileencoding = 'utf-8'
let g:omit_fileformat = 'unix'

let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [
    \       ['mode'],
    \       ['filename', 'readonly', 'modified'],
    \       ['ale']
    \   ],
    \   'right': [
    \       ['lineinfo'],
    \       ['percent'],
    \       ['fileformat', 'fileencoding', 'filetype']
    \   ]
    \ },
    \ 'component_function': {
    \   'ale':      'MyLineAle',
    \   'fileencoding': 'MyLineFileencoding',
    \   'fileformat':   'MyLineFileformat',
    \   'filename': 'MyLineFilename',
    \   'filetype': 'MyLineFiletype',
    \   'lineinfo': 'MyLineInfo',
    \   'mode':     'MyLineMode',
    \   'percent':  'MyLinePercent',
    \   'readonly': 'MyLineReadonly',
    \ }
    \ }

function! MyLineMode()
  if &filetype ==# 'denite'
    let l:mode_str = substitute(denite#get_status_mode(), "-\\| ", "", "g")
    call lightline#link(tolower(l:mode_str[0]))
    return l:mode_str
  else
    return winwidth(0) > g:responsive_width_small ? lightline#mode() : ''
  endif
endfunction

function! MyLineFilename()
  return &filetype ==# 'denite' ? denite#get_status_sources() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

function! MyLineReadonly()
    return winwidth(0) > g:responsive_width_mid ?
        \ (&filetype !~? 'help' && &readonly ? '' : '') : ''
endfunction

function! MyLineAle()
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   '%d %d',
    \   l:all_non_errors,
    \   l:all_errors
    \)
endfunction

function! MyLineFileformat()
    return winwidth(0) > g:responsive_width_mid ?
        \ (&fileformat !=# g:omit_fileformat ? &fileformat : '') : ''
endfunction

function! MyLineFileencoding()
    return winwidth(0) > g:responsive_width_mid ?
        \ (&fileencoding !=# '' ?
            \ (&fileencoding !=# g:omit_fileencoding ? &fileencoding : '') :
                \ (&encoding !=# g:omit_fileencoding ? &encoding : '')) : ''
endfunction

function! MyLineFiletype()
    if winwidth(0) > g:responsive_width_mid
        if &filetype !=# ''
            return &filetype
        else
            return 'no ft'
        endif
    else
        return ''
    endif
endfunction
        
function! MyLinePercent()
    if winwidth(0) > g:responsive_width_small
        if &filetype ==# 'denite'
            return ''
        else
            return printf('%2d%%', line('.') * 100 / line('$'))
        endif
    else
        return ''
    endif
endfunction

function! MyLineInfo()
    if &filetype ==# 'denite'
        return denite#get_status_linenr()
    else
        return printf('%d:%-2d', line('.'), col('.'))
    endif
endfunction
        
" buftabline
let g:buftabline_numbers = 2
highlight link BufTabLineCurrent PmenuSel
highlight link BufTabLineActive TabLineSel
" =====> theme-cake

" <===== controller-jet
" == directory source
" use Ag in file_rec command
call denite#custom#var('directory_rec', 'command',
\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" == file_rec source
" use Ag in file command
call denite#custom#var('file_rec', 'command',
\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" == grep source
" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" == options
call denite#custom#option('default', {
    \ 'highlight_matched_char': 'LineNr',
    \ 'highlight_mode_insert': 'Search',
    \ 'statusline': v:false
    \ })

" == keymappings
call denite#custom#map(
    \ '_',
    \ '<Esc>',
    \ '<denite:quit>',
    \ 'noremap',
    \)

" buffer delete
call denite#custom#map(
    \ 'normal',
    \ '/',
    \ '<denite:do_action:delete>',
    \ 'noremap',
    \)

call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

" =====> controller-jet

" <===== typing-candy
" == easymotion
nmap <Leader><Leader>s <Plug>(easymotion-s2)
nmap <Leader><Leader>L <Plug>(easymotion-overwin-line)

" =====> typing-candy

" <===== programming-rock
" == deoplete
let g:deoplete#enable_at_startup=1

" complete
inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#mappings#manual_complete()
		function! s:check_back_space() abort "{{{
		let l:col = col('.') - 1
		return !l:col || getline('.')[l:col - 1]  =~ '\s'
		endfunction"}}}
" close popup
inoremap <expr><C-h>
		\ deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>
		\ deoplete#smart_close_popup()."\<C-h>"
" undo complete
inoremap <expr><C-g> deoplete#undo_completion()

" == ale
let g:ale_lint_delay=500

" == vim-racer
let g:racer_cmd = '$HOME/.cargo/bin/racer'
let g:racer_experimental_completer = 1
" =====> programming-rock

" <===== utils-accel
" ranger.vim
let g:ranger_map_keys = 0
" =====> utils-accel

" <===== leader key-map
" temporary
nnoremap <Leader>\ :source $MYVIMRC<CR>

" ==Navigation -- <Leader> (feel free as i3)
" switch buffer by bufnr
nmap <Leader>1 <Plug>BufTabLine.Go(1)
nmap <Leader>2 <Plug>BufTabLine.Go(2)
nmap <Leader>3 <Plug>BufTabLine.Go(3)
nmap <Leader>4 <Plug>BufTabLine.Go(4)
nmap <Leader>5 <Plug>BufTabLine.Go(5)
nmap <Leader>6 <Plug>BufTabLine.Go(6)
nmap <Leader>7 <Plug>BufTabLine.Go(7)
nmap <Leader>8 <Plug>BufTabLine.Go(8)
nmap <Leader>9 <Plug>BufTabLine.Go(9)

" navigate buffers
nnoremap <Leader>] :bnext<CR>
nnoremap <Leader>[ :bprevious<CR>

" navigate windows
nnoremap <Leader>j <C-w>h
nnoremap <Leader>k <C-w>j
nnoremap <Leader>l <C-w>k
nnoremap <Leader>; <C-w>l

" move window
nnoremap <Leader>J <C-w>H
nnoremap <Leader>K <C-w>J
nnoremap <Leader>L <C-w>K
nnoremap <Leader>: <C-w>L

" close window
nnoremap <Leader>/ <C-w>c

" ==Files -- <Leader> + f
" open in current window
nnoremap <Leader>ff :Ranger<CR>

" open mru file
nnoremap <Leader>fr :Denite
    \ file_mru<CR>

" open file and split
nnoremap <Leader>fg :call OpenRangerIn("%:p:h", 'vsplit ')<CR>
nnoremap <Leader>fn :call OpenRangerIn("%:p:h", 'split ')<CR>

" open a new file
nnoremap <Leader>fm :Denite
    \ file:new<CR>

" save
nnoremap <Leader>fs :w<CR>
nnoremap <Leader>fS :wall<CR>

" ==Buffers -- <Leader> + b
" denite
nnoremap <Leader>bb :Denite -mode=normal buffer<CR>

" ==Windows -- <Leader> + w
" split current window
nnoremap <Leader>wg <C-w>v
nnoremap <Leader>wn <C-w>s

" split a new empty window
nnoremap <Leader>wsg :vnew<CR>
nnoremap <Leader>wsn :new<CR>

" ==Quit -- <Leader> + q
nnoremap <Leader>qs :xall<CR>
nnoremap <Leader>qq :qall<CR>
nnoremap <Leader>qQ :qall!<CR>

" ==Help -- <Leader> + h
nnoremap <Leader>hh :Denite help<CR>

" =====> leader key-map
