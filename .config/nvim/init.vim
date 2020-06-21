syntax on
syntax sync fromstart
syntax sync minlines=1000
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
"set list listchars=nbsp:¬,tab:»·,trail:·,extends:>,precedes:<
set showbreak=↳
set wrap

set encoding=utf-8

set termguicolors

set laststatus=0

colorscheme fortnest

nnoremap <space><space> :noh<cr>
"map <F11> :w <CR> :!gcc % -o %< && ./%< <CR>
"map <F11> :w <CR> :!make %< && ./%< <CR>
"map <F12> :!make<cr>
nnoremap <F12> :!go run %<cr>
nnoremap <F11> <C-w>h :q<cr>
nnoremap <F10> <C-w>j :q<cr>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <F4> :syntax sync fromstart<CR>
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

" Displays the indention levels with thin vertical lines
Plug 'thaerkh/vim-indentguides'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'Yggdroot/indentLine'

" Viewer & Finder for LSP symbols and tags
"Plug 'liuchengxu/vista.vim'

" Highlightning
"Plug 'sheerun/vim-polyglot'

" Go things
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

"let g:indentguides_spacechar = '│'
let g:indentguides_spacechar = '┃'

let g:go_fmt_command = "goimports"

"let g:indent_guides_enable_on_vim_startup=1
"let g:indent_guides_auto_colors=0
"hi IndentGuidesEven ctermbg=white
"hi IndentGuidesOdd ctermbg=black
