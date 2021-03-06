local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--map("", "<ScrollWheelUp>", "<C-y>", opts)
--map("", "<ScrollWheelDown>", "<C-e>", opts)

map("n", "<C-j>", "<C-W>j", opts)
map("n", "<C-k>", "<C-W>k", opts)
map("n", "<C-h>", "<C-W>h", opts)
map("n", "<C-l>", "<C-W>l", opts)
map("n", "H", "^", opts)
map("n", "L", "$", opts)
map("n", "rhi", ":resize +2<CR>", opts)
map("n", "rhm", ":resize -2<CR>", opts)
map("n", "rvi", ":vert resize +2<CR>", opts)
map("n", "rvm", ":vert resize -2<CR>", opts)

map("", "<C-n>", ":tabnew<CR>", opts)
map("", "<C-w>", ":tabclose<CR>", opts)
map("", "<A-t>", ":tabnext<CR>", opts)
map("", "<A-T>", ":tabprevious<CR>", opts)

map("n", "<C-a>", ":%y+<CR>", opts) -- Copy whole file
map("v", "<C-c>", "\"+y", opts) -- Copy selected
map("v", "H", "^", opts)
map("v", "L", "$", opts)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

vim.cmd([[
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-J> <C-\><C-n><C-W>j
    tnoremap <C-H> <C-\><C-n><C-W>h
    tnoremap <C-K> <C-\><C-n><C-W>k
    "tnoremap <C-L> <C-\><C-n><C-W>l
]])

-- Plugins
map("n", "<C-f>", ":NvimTreeToggle<CR>", opts)
map("n", "<C-s>", ":SymbolsOutline<CR>", opts)
map("n", "ff", ":Telescope find_files<CR>", opts)
map("n", "fg", ":Telescope live_grep<CR>", opts)

vim.cmd([[
function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
map gm :call SynGroup()<CR>
]])
