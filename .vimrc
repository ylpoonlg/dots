" vim-bootstrap 2023-03-09 15:54:29

"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

let g:vim_bootstrap_langs = "c,haskell,html,javascript,lua,perl,php,python,rust,typescript"
let g:vim_bootstrap_editor = "vim"				" nvim or vim
let g:vim_bootstrap_theme = "molokai"
let g:vim_bootstrap_frams = "vuejs"

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif


"*****************************************************************************
"" Plug install packages
"*****************************************************************************
" Required:
call plug#begin(expand('~/.vim/plugged'))

Plug 'itchyny/lightline.vim'
"Plug 'vim-scripts/grep.vim'
Plug 'crusoexia/vim-monokai'
Plug 'tomasr/molokai'   " fallback

" Assembly
Plug 'alisdair/vim-armasm'

" Completion
Plug 'maralla/completor.vim'

call plug#end()

" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0   " Auto: use tabstop
set shiftwidth=0    " Auto: use tabstop
set expandtab
set smarttab
set linebreak
set nowrap

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undodir
set history=512

set number
set laststatus=2
set showtabline=2
set cursorline
set noshowmode
set nomodeline

set termguicolors
syntax on

colorscheme monokai

set mouse=a
set splitright
set splitbelow
set nocompatible
set wildmenu



"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall


"*****************************************************************************
"" Commands
"*****************************************************************************

" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e


"*****************************************************************************
"" Mappings
"*****************************************************************************

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <C-n> :tabnew<CR>

noremap H ^
noremap L $

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>


"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

vmap H ^
vmap L $

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


"*****************************************************************************
"" Language Specifics
"*****************************************************************************

" ARM ASM
autocmd BufRead,BufNewFile *.s set filetype=armasm
autocmd FileType armasm setlocal tabstop=2

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" LightLine
let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
      \ }

" Completor
let g:completor_complete_options = 'menuone,noselect,preview'
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
autocmd InsertCharPre * call completor#do('complete')
