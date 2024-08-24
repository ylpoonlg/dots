local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Cursor
map("n", "<S-h>", "^", opts)
map("n", "<S-l>", "$", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "<S-n>", "Nzzzv", opts)
map("n", "<C-I>", "<C-S-I>", opts) -- Previous cursor

-- Windows
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<leader>rzj", ":resize +4<CR>", opts)
map("n", "<leader>rzk", ":resize -4<CR>", opts)
map("n", "<leader>rzl", ":vert resize +4<CR>", opts)
map("n", "<leader>rzh", ":vert resize -4<CR>", opts)

-- Editing
map("n", "x", "\"_x", opts)
map("n", "c", "\"_c", opts)
map("x", "<leader>d", "\"_d", opts)
map("x", "<leader>p", "\"_dP", opts) -- Discard overwritten text for paste

-- Buffers
map("n", "<C-w>", ":bdelete<CR>", opts)
map("n", "<A-Tab>", ":bnext<CR>", opts)
map("n", "<A-S-Tab>", ":bprevious<CR>", opts)

-- Tabs
map("n", "<leader><C-n>", ":tabnew<CR>", opts)
map("n", "<leader><A-Tab>", ":tabnext<CR>", opts)
map("n", "<leader><A-S-Tab>", ":tabprevious<CR>", opts)

-- Misc.
map("n", "<C-a>", ":%y+<CR>", opts) -- Copy whole file
map("n", "z]", "v}kzf", opts)
map("n", "z[", "{jv}kzf", opts)

-- Insert Mode
map("i", "<C-BS>", "<Esc>cvb", opts)

-- Visual Mode
map("v", "<C-c>", "\"+y", opts) -- Copy selected
map("v", "<S-h>", "^", opts)
map("v", "<S-l>", "$", opts)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("v", "<S-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<S-k>", ":m '<-2<CR>gv=gv", opts)

-- Identifier
vim.cmd([[
    function! SynGroup()
        let l:s = synID(line('.'), col('.'), 1)
        echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
    endfun
    map gm :call SynGroup()<CR>
]])

map("n", "<C-f>", ":NvimTreeToggle<CR>", opts)
