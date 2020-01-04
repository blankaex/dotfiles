"
" Leader
"

let mapleader =" "


"
" Plugins
"

execute pathogen#infect()


"
" UI
"

syntax on
colorscheme wal
set t_Co=256
set splitbelow
set splitright
set guicursor=
set scrolloff=3
set sidescrolloff=5
set display+=lastline


"
" Tabs
"

set expandtab
set tabstop=4
set shiftwidth=4
set number relativenumber numberwidth=5
set smarttab
set ai
set si


"
" Search
"

set ignorecase
set smartcase
set incsearch
set magic


"
" Sound
"

set noerrorbells
set novisualbell
set t_vb=
set tm=500


"
" Files
"
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
filetype plugin indent on
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"
" Keybinds
"

" Short commands
nmap <silent><leader>d dd
nmap <silent><leader>y yy
nmap <silent><leader>w :w<cr>
nmap <silent><leader>q :q<cr>
nmap <silent><leader>x :x<cr>
nmap <silent><leader>f zA
nmap <silent><leader>a zR
nmap <silent><leader>s zM

" Custom
nmap S :%s//g<Left><Left>
nmap <silent><leader>c gcc
nmap <silent><leader>n :NERDTreeToggle<cr>
nmap <silent><leader>g :Goyo<cr>
nmap <silent><leader>p :set cursorcolumn!<Bar>set cursorline!<cr>
nmap <silent><leader><leader> :let @/ = ""<cr>

" Switch splits with leader+[hjkl]
nmap <silent><leader>h <C-W><C-H>
nmap <silent><leader>j <C-W><C-J>
nmap <silent><leader>k <C-W><C-K>
nmap <silent><leader>l <C-W><C-L>

" Navigate display lines
nmap <buffer> <silent> k gk
nmap <buffer> <silent> j gj
nmap <buffer> <silent> 0 g0
nmap <buffer> <silent> $ g$


"
" Types
"

aug unicode
    au!
    au BufRead,BufNewFile *.ass imap -- —
    au BufRead,BufNewFile *.md imap -- —
    au BufRead,BufNewFile *.tex imap -- —
    au BufRead,BufNewFile *.yml,*.yaml imap -- —
aug END

aug spacing
    au!
    au BufRead,BufNewFile *.html set shiftwidth=2 tabstop=2
    au BufRead,BufNewFile *.json set shiftwidth=2 tabstop=2
    au BufRead,BufNewFile *.yaml,*.yml set shiftwidth=2 tabstop=2
aug END

aug ass
    au!
    au BufRead,BufNewFile *.ass imap !! {\i1}
    au BufRead,BufNewFile *.ass imap !" {\i0}
    au BufRead,BufNewFile *.ass nmap <leader>- i—<Esc>
    au BufRead,BufNewFile *.ass nmap <leader>i i{\i1}<Esc>
    au BufRead,BufNewFile *.ass nmap <leader>o a{\i0}<Esc>
aug END

aug html
    highlight link htmlTag htmlTagName
    highlight link htmlEndTag htmlTagName
aug END

aug latex
    au!
    au BufWritePost *.tex silent Make!
    au VimLeave *.tex silent make clean
aug END

aug python
    au!
    au BufRead,BufNewFile *.py set foldmethod=indent
aug END
