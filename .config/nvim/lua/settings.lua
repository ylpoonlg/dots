vim.opt.number = true
vim.opt.laststatus = 2
vim.opt.showtabline = 2
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.modeline = false

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.linebreak = true
vim.opt.wrap = false
vim.cmd("set colorcolumn=80")
vim.opt.foldmethod = "manual"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4 vim.opt.shiftwidth = 4
vim.opt.mouse = 'a'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.compatible = false
vim.opt.errorbells = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.ignorecase = true
vim.opt.showmatch = true
vim.opt.pumheight = 10

vim.opt.undodir = vim.fn.expand('~/.cache/nvim/undodir')
vim.opt.undofile = true
vim.opt.history=512

vim.opt.incsearch = true

vim.cmd('syntax on')
vim.opt.termguicolors = true

-- Terminal
vim.cmd(
-- Check if the terminal is not the preview header for dashboard-nvim
"autocmd BufWinEnter,BufEnter,WinEnter,TermOpen * if &buftype == 'terminal' | "..
"if stridx(execute('lua print(vim.api.nvim_buf_get_name(0))'), 'preview_header') < 0 | "..
":startinsert"..
" | endif"..
" | endif"
)
vim.cmd([[
command TermJ :split | :term
command TermL :vsplit | :term
]])

-- Session
local session_cache_path = "~/.cache/nvim/last_session.nvim"
vim.cmd(
"autocmd BufWritePost * mks! "..session_cache_path
)
function last_session()
    vim.cmd("source "..session_cache_path)
end
