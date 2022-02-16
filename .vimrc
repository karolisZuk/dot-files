"""""""""""""""""""""""""""""""""""""
" Karolis Zukas Vim config 
"""""""""""""""""""""""""""""""""""""
set hidden
set nocompatible
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set mouse=a
set incsearch
set ignorecase
set smartcase
set hlsearch

if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'dense-analysis/ale'
Plugin 'tpope/vim-fugitive'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'itchyny/lightline.vim'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin' 
Plugin 'ap/vim-buftabline'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'prettier/vim-prettier'
Plugin 'othree/xml.vim'
Plugin 'othree/html5.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'tpope/vim-surround'
Plugin 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plugin 'airblade/vim-gitgutter'

call vundle#end()
filetype plugin indent on

" Formatting
set encoding=utf8
set nowrap
set backspace=indent,eol,start
set relativenumber
set number

set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set laststatus=2
syntax on
set t_Co=256
set smartcase
set smartindent
set colorcolumn=100

set list
set listchars=tab:→\ ,space:·,precedes:«,extends:»

highlight ColorColumn ctermbg=0 guibg=lightgrey

colorscheme duckbones

"""""""""""""""""""""""""""""""""""""
" Mappings configurationn
"""""""""""""""""""""""""""""""""""""
map <C-b> :NERDTreeToggle<CR>

" CoC
" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart

" Sweet Sweet FuGITive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

" Movedd highlighted text up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <A-f> :Ag<CR>
nnoremap <C-p> :Files<CR>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

set statusline+=%#warningmsg#

" Fix files automatically on save
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['prettier', 'eslint'],
\}

let g:ale_javascript_eslint_use_global = 1
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'css': ['stylelint'],
\  'scss': ['stylelint'],
\}

autocmd FileType xml,html inoremap </ </<C-x><C-o>

let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_fix_on_save = 1

let g:NERDTreeQuitOnOpen = 1 

" Close NERDTree when closing the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
