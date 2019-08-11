" Plugins
execute pathogen#infect()

" UI
syntax on
colorscheme wal
set t_Co=256
set splitbelow
set splitright
set guicursor=
set scrolloff=3
set sidescrolloff=5
set display+=lastline

" Tabs
set expandtab
set tabstop=4
set shiftwidth=4
set number relativenumber numberwidth=5
set smarttab
set ai
set si

" Search
set ignorecase
set smartcase
set nohlsearch
set incsearch
set magic

" Sound
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Files
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
filetype plugin indent on
au FileType c,cpp,cs,java setlocal commentstring=//\ %s
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Auto commands
augroup latex
    au!
    au BufWritePost *.tex silent Make!
    au VimLeave *.tex silent make cean
augroup END

" Keybinds
let mapleader =" "
nmap S :%s//g<Left><Left>
" Plugins
nmap <leader>c gcc
nmap <silent><leader>n :NERDTreeToggle<cr>
nmap <silent><leader>g :Goyo<cr>
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

