syntax on
set rnu
set clipboard=unnamedplus
set expandtab
set ai
set hlsearch
set ignorecase
set bs=2

set tabstop=4
set softtabstop=4
set shiftwidth=4
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>

set encoding=utf-8

set termguicolors

set laststatus=0

colorscheme fortnest

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"set laststatus=0
"set background=dark

call plug#begin('~/.local/share/nvim/plugged/')

" Ansible syntax highlighting
"Plug 'MicahElliott/Rocannon'

" YAML Highlightning
Plug 'stephpy/vim-yaml'
"Plug 'chase/vim-ansible-yaml'

" Jenkinsfile Highlitning
Plug 'martinda/Jenkinsfile-vim-syntax'

" Highlightning
"Plug 'sheerun/vim-polyglot'

" Go things
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

