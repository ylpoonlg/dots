-- Generic Plugins

return {
    "onsails/lspkind.nvim",
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            triggers = {
            }
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show()
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    "nvim-lua/plenary.nvim",
    {
        "karb94/neoscroll.nvim",
        config = function ()
            require('neoscroll').setup({
                mappings = {
                    '<C-u>', '<C-d>',
                    '<C-y>', '<C-e>',
                    '<C-y>', '<C-e>',
                },
            })
        end
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function ()
            require("colorizer").setup {"*"}
        end,
    },
    {
        "lukas-reineke/virt-column.nvim",
        config = function ()
            require("virt-column").setup({})

            vim.api.nvim_set_hl(0, "VirtColumn", { link="ColorColumn" })
        end,
    },
    {
        "knubie/vim-kitty-navigator",
        config = function ()
            local opts = { noremap = true, silent = true }

            vim.keymap.set("n", "<C-A-h>", ":KittyNavigateLeft<CR>", opts)
            vim.keymap.set("n", "<C-A-j>", ":KittyNavigateDown<CR>", opts)
            vim.keymap.set("n", "<C-A-k>", ":KittyNavigateUp<CR>", opts)
            vim.keymap.set("n", "<C-A-l>", ":KittyNavigateRight<CR>", opts)
        end,
    },
}
