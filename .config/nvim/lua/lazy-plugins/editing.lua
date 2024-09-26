return {
    {
        "echasnovski/mini.ai",
        version = false,
        config = true,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "<leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                keymaps = {
                    insert = "<C-g>s",
                    insert_line = "<C-g>S",
                    normal = "ys",
                    normal_cur = "yss",
                    normal_line = "yS",
                    normal_cur_line = "ySS",
                    visual = "s",
                    visual_line = "S",
                    delete = "ds",
                    change = "cs",
                    change_line = "cS",
                },
            })
        end
    },
    {
        "numToStr/Comment.nvim",
        config = true,
    },
}
