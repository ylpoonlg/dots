syntax on

" Plugins
" use :PlugInstall to install
call plug#begin("~/.vim/plugged")
    Plug 'tanvirtin/monokai.nvim'
    Plug 'itchyny/lightline.vim'
    Plug 'lervag/vimtex'
    Plug 'preservim/nerdtree'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'simrat39/symbols-outline.nvim'
    Plug 'karb94/neoscroll.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'numToStr/Comment.nvim'

    "Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'dart-lang/dart-vim-plugin'
call plug#end()

" Interface
set number
set noshowmode
set laststatus=2
set showtabline=2
set cursorline

" Behavior
set tabstop=4 softtabstop=0 shiftwidth=4  smarttab
set expandtab
set smartcase
set smartindent
"set wrap
set mouse=a
set splitright
set splitbelow

" Disabled
set nocompatible
set noerrorbells
set noswapfile
set nobackup
set nomodeline

" Features
set ignorecase
set showmatch

" Undo
set undodir=~/.vim/undodir
set undofile
set history=512

" Search
set incsearch
set path=.,,**

" Appearance
colorscheme monokai

" Syntax Highlighting
function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
map gm :call SynGroup()<CR>

" Status Line
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'enable': {
      \   'tabline': 0
      \ },
      \ 'tabline': {
      \   'left': [ [ 'tabs' ] ],
      \   'right': [ [ 'close' ] ],
      \ },
      \ 'tab' : {
      \   'active': [ 'tabnum', 'filename', 'modified' ],
      \   'inactive': [ 'tabnum', 'filename', 'modified' ],
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ],
      \             [ 'cwd' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat' ] ]
      \ },
      \ 'component': {
	  \   'lineinfo': '%3l:%-2c%<',
      \ },
      \ 'component_function': {
      \   'cwd': 'LightlineCwd',
      \   'fileformat': 'LightlineFileformat',
      \ },
      \ }

function! LightlineCwd()
    return winwidth(0) > 70 ? getcwd() : ''
endfunction
function! LightlineFileformat()
    return winwidth(0) > 100 ? &fileformat . " - " . &filetype : ''
endfunction

" NerdTree
let g:NERDTreeWinPos = "left"
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Symbols Outline
let g:symbols_outline = {}

" Autocompletion
set completeopt=menu,menuone,noselect
luafile ~/.config/nvim/autocompletion/cmp-config.lua
luafile ~/.config/nvim/autocompletion/language-servers.lua
"let g:coc_global_extensions = [
"\'coc-html',
"\'coc-css',
"\'coc-json',
"\'coc-pyright',
"\'coc-java',
"\'coc-tsserver',
"\'coc-sh',
"\'coc-r-lsp',
"\'coc-clangd',
"\]
set pumheight=10
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 100)


" Plug Config
lua require('neoscroll').setup()
lua require('Comment').setup()
lua require('nvim-web-devicons').setup()
lua require('nvim-tree').setup()
set termguicolors
lua << EOF
require('bufferline').setup {
    options = {
        mode = "tabs",
        separator_style = "slant",
        close_icon = '',
        buffer_close_icon = '',
        offsets = {{filetype = "NvimTree", text = "Files", highlight = "Directory", text_align = "left"}}
    }
}
EOF

" Key bindings
" Basic
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap rhi :resize +2<CR>
nnoremap rhm :resize -2<CR>
nnoremap rvi :vert resize +2<CR>
nnoremap rvm :vert resize -2<CR>
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
"map <ScrollWheelUp> <C-y>
"map <ScrollWheelDown> <C-e>

" Terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <C-j> <C-\><C-n><C-W>j
tnoremap <C-h> <C-\><C-n><C-W>h
tnoremap <C-k> <C-\><C-n><C-W>k
" C-l is used for clearing the terminal: tnoremap <C-l> <C-\><C-n><C-W>l
autocmd BufWinEnter,BufEnter,WinEnter,TermOpen * if &buftype == 'terminal' | :startinsert | endif
command TermJ :split | :term
command TermL :vsplit | :term

" Tabs/FileExplorer/Symbols
nnoremap <C-f> :NvimTreeToggle<CR>
nnoremap <C-s> :SymbolsOutline<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <C-a> :%y+<CR>
vnoremap <C-c> "+y
noremap <C-w> :tabclose<CR>
map <M-t> :tabnext<CR>
map <M-T> :tabprevious<CR>

" Telescope
nnoremap ff :Telescope find_files<cr>
nnoremap fg :Telescope live_grep<cr>
nnoremap fb :Telescope buffers<cr>
nnoremap fh :Telescope help_tags<cr>

