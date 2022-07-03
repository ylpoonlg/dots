require("virt-column").setup()
require('nvim-web-devicons').setup()  -- must be set after <colorscheme> command
require('neoscroll').setup()
require('Comment').setup()
require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = require('telescope.actions').move_selection_next,
                ["<C-k>"] = require('telescope.actions').move_selection_previous,
            },
        },
    },
})

require('lsp')
