return {
    {
        "tpope/vim-fugitive",
        config = function ()
            local map = vim.keymap.set
            local opts = { noremap = true, silent = true }

            map("n", "<leader>ga", ":Gwrite<CR>", opts)
            map("n", "<leader>gc", ":Git commit<CR>", opts)
            map("n", "<leader>gd", ":Gvdiff!<CR>", opts)
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = true,
    },
}
