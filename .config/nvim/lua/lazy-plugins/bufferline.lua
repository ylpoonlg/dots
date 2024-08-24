return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
        require("bufferline").setup {
            options = {
                mode = "buffers",
                numbers = "ordinal",
                separator_style = "thin",
                close_icon = "",
                buffer_close_icon = "",
                color_icons = true,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Tree",
                        highlight = "Directory",
                        text_align = "center",
                    },
                },
            }
        }

        vim.api.nvim_set_hl(0, "BufferLineFill", { ctermbg=0, bg="#000000" })
    end
}
