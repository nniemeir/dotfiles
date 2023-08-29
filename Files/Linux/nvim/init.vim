set number
set linebreak
syntax on
set encoding=utf8
setlocal spell
set spelllang=nl,en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
call plug#begin()
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'preservim/nerdtree'
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
call plug#end()
colorscheme catppuccin-mocha
autocmd filetype markdown syn region match start=/\\$\\$/ end=/\\$\\$/
autocmd filetype markdown syn match math '\\$[^$].\{-}\$'
nnoremap <down> gj
nnoremap <up> gk
nnoremap gj <down>
nnoremap gk <up>
