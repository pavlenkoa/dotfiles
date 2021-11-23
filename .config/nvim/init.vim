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
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>,precedes:<
set showbreak=↳
set wrap
set mouse=a

set encoding=utf-8

set termguicolors
set laststatus=0

set undofile

set completeopt=menuone,noselect

colorscheme dunno
hi Normal guibg=NONE ctermbg=NONE

nnoremap <space><space> :noh<cr>
"map <F11> :w <CR> :!gcc % -o %< && ./%< <CR>
"map <F11> :w <CR> :!make %< && ./%< <CR>
map <F11> :w <CR> :!make %< && ./%< <CR>
"map <F12> :!make<cr>
"nnoremap <F12> :!go run %<cr>
"nnoremap <F11> <C-w>h :q<cr>
"nnoremap <F10> <C-w>j :q<cr>

" F5 to clear white spaces
nnoremap <silent> <F5> :%s/\s\+$//e

"nnoremap <D-j> :m+ <CR>
"nnoremap <D-k> :m- <CR>
""inoremap <C-j> <Esc>:m +1<CR>==gi
""inoremap <C-k> <Esc>:m -2<CR>==gi
"vnoremap <C-j> :m '>+1<CR>gv=gv
"vnoremap <C-k> :m '<-2<CR>gv=gv

noremap <F4> :syntax sync fromstart<CR>

"set laststatus=0

call plug#begin('~/.local/share/nvim/plugged/')

" Ansible syntax highlighting
"Plug 'MicahElliott/Rocannon'

" JSON/YAML formatting
"Plug 'dense-analysis/ale'

" YAML Highlightning
Plug 'stephpy/vim-yaml'
"Plug 'chase/vim-ansible-yaml'

" Git thingie
Plug 'tpope/vim-fugitive'

" Jenkinsfile Highlitning
Plug 'martinda/Jenkinsfile-vim-syntax'

" Better Highlitning
Plug 'nvim-treesitter/nvim-treesitter'

" Displays the indention levels with thin vertical lines
"Plug 'thaerkh/vim-indentguides'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'Yggdroot/indentLine'

" Viewer & Finder for LSP symbols and tags
"Plug 'liuchengxu/vista.vim'

" Highlightning
"Plug 'sheerun/vim-polyglot'

" Go things
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

"let g:indentguides_spacechar = '│'
let g:indentguides_spacechar = '┃'

let g:go_fmt_command = "goimports"

let g:ale_sign_column_alwayus = 1
"let g:indent_guides_enable_on_vim_startup=1
"let g:indent_guides_auto_colors=0
"hi IndentGuidesEven ctermbg=white
"hi IndentGuidesOdd ctermbg=black
