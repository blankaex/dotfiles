"
" Leader
"

let mapleader =" "


"
" Plugins
"

call plug#begin('~/.config/nvim/plugins')
Plug 'h-hg/fcitx.nvim'
Plug 'preservim/nerdtree'
Plug 'dylanaraps/wal.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'stephpy/vim-yaml'
Plug 'psliwka/vim-smoothie'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
call plug#end()


"
" UI
"

syntax on
colorscheme wal
set nocompatible
set notermguicolors
set background=dark
hi StatusLine ctermfg=2
set t_Co=256
set splitbelow
set splitright
set guicursor=
set mouse=
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
nmap <silent><leader>t zt
nmap <silent><leader>b zb
nmap <silent><leader>k {
nmap <silent><leader>j }

" Custom
nmap S :%s//g<Left><Left>
nmap <silent><leader>c gcc
nmap <silent><leader>n :NERDTreeToggle<cr>
nmap <silent><leader>g :Goyo<cr>
nmap <silent><leader>p :set cursorcolumn!<Bar>set cursorline!<cr>
nmap <silent><leader>I :PlugInstall<cr>
nmap <silent><leader><leader> :let @/ = ""<cr>
imap <expr>A pumvisible() ? deoplete#insert_candidate(0) : 'A'
imap <expr>S pumvisible() ? deoplete#insert_candidate(1) : 'S'
imap <expr>D pumvisible() ? deoplete#insert_candidate(2) : 'D'
imap <expr>F pumvisible() ? deoplete#insert_candidate(3) : 'F'
imap <expr>G pumvisible() ? deoplete#insert_candidate(4) : 'G'

" Switch splits with leader+[hjkl]
nmap <silent><leader>h <C-W><C-H>
" nmap <silent><leader>j <C-W><C-J>
" nmap <silent><leader>k <C-W><C-K>
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
    au BufRead,BufNewFile *.md imap == ---
    au BufRead,BufNewFile *.yml,*.yaml imap -- —
aug END

aug latex
    au!
    set conceallevel=2
    au BufWritePost *.tex silent !make
    au VimLeave *.tex silent !make clean
aug END

aug ass
    au!
    au BufRead,BufNewFile *.ass imap !! {\i1}
    au BufRead,BufNewFile *.ass imap !" {\i0}
    au BufRead,BufNewFile *.ass nmap <leader>- i—<Esc>
    au BufRead,BufNewFile *.ass nmap <leader>i i{\i1}<Esc>
    au BufRead,BufNewFile *.ass let page = 1
    au bufRead,BufNewFile *.ass nmap <leader>o :exe "normal! a{" . page . "}\r" \| let page += 1 \| startinsert<cr>
aug END

aug html
    highlight link htmlTag htmlTagName
    highlight link htmlEndTag htmlTagName
aug END

aug spacing
    au!
    au BufRead,BufNewFile *.html set shiftwidth=2 tabstop=2
    au BufRead,BufNewFile *.json set shiftwidth=2 tabstop=2
    au BufRead,BufNewFile *.yaml,*.yml set shiftwidth=2 tabstop=2
aug END

aug eroge
    au BufRead,BufNewFile *.yml,*.yaml imap RE Ren: "
    au BufRead,BufNewFile *.yml,*.yaml imap MA Mafuyu: "
    au BufRead,BufNewFile *.yml,*.yaml imap CO Cocoa: "
    au BufRead,BufNewFile *.yml,*.yaml imap RO Reon: "
    au BufRead,BufNewFile *.yml,*.yaml imap SO Solly: "
    au BufRead,BufNewFile *.yml,*.yaml imap OW Owner: "
    au BufRead,BufNewFile *.yml,*.yaml imap AA Ah...
    au BufRead,BufNewFile *.yml,*.yaml imap MM Mmm...
    au BufRead,BufNewFile *.yml,*.yaml imap NN Ngh...
    au BufRead,BufNewFile *.yml,*.yaml imap SS *smooch*...
    au BufRead,BufNewFile *.yml,*.yaml imap LL *slurp*...
aug END
