-- Dashboard
local home = os.getenv('HOME')

-- db.preview_command     = 'cat | lolcat -F 0.08 -S 42 -a -d 1'
-- db.preview_file_path   = home .. '/.config/nvim/preview_header.txt'
-- db.preview_file_width  = 62
-- db.preview_file_height = 14
-- function get_nvim_version()
--     return vim.api.nvim_exec([[
--         echo matchstr(execute('version'), 'NVIM v\zs[^\n]*')
--     ]], true)
-- end
-- db.custom_footer = {
-- '',
-- '',
-- '',
-- '',
-- '',
-- '[NVIM '..get_nvim_version()..']',
-- }
-- local function open_file_path (path, filename)
--     return ':cd ' .. path .. ' | :e ' .. path .. filename
-- end
-- db.custom_center = {
--     {icon = '  ',
--     desc = 'Last Session  ',
--     action = 'lua last_session()',
--     shortcut = ''},
--     {icon = '  ',
--     desc = 'New File      ',
--     action = 'DashboardNewFile',
--     shortcut = ''},
--     {icon = '  ',
--     desc = 'Open A File   ',
--     action = 'Telescope find_files',
--     shortcut = ''},
--     {icon = '  ',
--     desc = 'Neovim Config ',
--     shortcut = '',
--     action = open_file_path(home..'/.config/nvim/',  'init.lua')},
--     {icon = '  ',
--     desc = 'Qtile Config  ',
--     shortcut = '',
--     action = open_file_path(home..'/.config/qtile/', 'config.py')},
--     {icon = '  ',
--     desc = 'Eww Config    ',
--     shortcut = '',
--     action = open_file_path(home..'/.config/eww/',   'eww.yuck')},
-- }


-- File Tree
require('nvim-tree').setup {
  open_on_tab = true,
  update_cwd = true,
  filesystem_watchers = {
      enable = false,
  },
  git = {
    ignore = false,
  },
  view = {
    mappings = {
       list = {
        { key = {"<ESC>", "q"}, action = "close" },
       },
    },
  },
}

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
  show_current_context = true,
  show_current_context_start = true,
}

-- Other
require('virt-column').setup {}
require('colorizer').setup {
  "*";
}
require('neoscroll').setup {}
require('Comment').setup {}
