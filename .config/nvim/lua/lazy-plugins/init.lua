-- Generic Plugins

return {
    "onsails/lspkind.nvim",
    "folke/which-key.nvim",
    "nvim-lua/plenary.nvim",
    {
        "karb94/neoscroll.nvim",
        config = true,
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
        "ur4ltz/surround.nvim",
        config = function ()
            require("surround").setup {
                mappings_style = "sandwich"
            }
        end
    },
    {
        "numToStr/Comment.nvim",
        config = true,
    },
    {
        "knubie/vim-kitty-navigator",
        config = function ()

        end,
    },
}
