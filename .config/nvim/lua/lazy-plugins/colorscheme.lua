return {
    {
        "Shatur/neovim-ayu",
        lazy = false,
        priority = 1000,
        config = function ()
            require("ayu").setup({})
            require("ayu").colorscheme()

            local ayu_colors = require("ayu.colors")
            ayu_colors.generate()

            -- Refresh Devicons Highlights
            require("nvim-web-devicons").refresh()

            -- Use Terminal Colors 
            vim.api.nvim_set_hl(0, "Normal", { bg="NONE" })
            vim.api.nvim_set_hl(0, "ColorColumn", { bg="NONE" })
            vim.api.nvim_set_hl(0, "VertSplit", { fg="#000000", bg="NONE" })
            vim.api.nvim_set_hl(0, "SignColumn", { bg="NONE" })

            vim.api.nvim_set_hl(0, "LineNr", { link="Comment" })
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        config = true,
    },
}
