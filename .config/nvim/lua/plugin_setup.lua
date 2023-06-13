-- Finder
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      },
    },
  },
}

-- More Highlighting
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

-- Symbols Outline
vim.g.symbols_outline = {
  width = 16,
}

-- Indent/Space lines
require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = false,
  show_current_context_start = false,
}
vim.cmd("let g:indent_blankline_char = '▏'")

-- Other
require('virt-column').setup {}
require('colorizer').setup {
  "*";
}
require('neoscroll').setup {}
require('Comment').setup {}

require('surround').setup {
  mappings_style = "sandwich"
}
