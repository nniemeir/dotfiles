" General
let mapleader = " "
colorscheme base16-black-metal
set encoding=utf8
set nobackup
set autoindent
set smartindent
set conceallevel=1

" Spellcheck
setlocal spell
set spelllang=en_us

" Display 
set cursorline
set relativenumber
set showcmd
set showmode
set showmatch
set wildmenu
set wildmode=list:longest
set colorcolumn=101
set whichwrap+=<,>,[,],h,l"
set iskeyword+==
set number
set linebreak
syntax on
set mouse=a
set laststatus=2 

" Highlighting
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none
set hlsearch
set incsearch

" Keymappings
nnoremap <down> gj
nnoremap <up> gk
nnoremap gj <down>
nnoremap gk <up>
map <C-b> :NERDTreeToggle<CR>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
noremap <C-F> :call fzf#vim#files('.')

"Filetypes
filetype on
filetype plugin on
filetype indent on
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd filetype markdown syn region match start=/\\$\\$/ end=/\\$\\$/
autocmd filetype markdown syn match math '\\$[^$].\{-}\$'

" Plugins
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'lervag/vimtex'
Plug 'junegunn/fzf.vim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
call plug#end()

" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

" Bufferline
set termguicolors
lua << EOF
require("bufferline").setup{}
EOF
