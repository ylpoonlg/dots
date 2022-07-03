-- Color Scheme
--vim.cmd('colorscheme monokai')
require('monokai').setup({
    palette = {
        name = 'monokai_lg',
        base1 = '#272822',
        base2 = '#2C2F38', -- Background
        base3 = '#22252E',
        base4 = '#22252E', -- Curly Brackets and Hightlights
        base5 = '#AAADAF', -- Numbering
        base6 = '#555657', -- Comments
        base7 = '#ADADAF',
        white = '#F8F8F0',
        grey = '#595959',
    },
})

vim.cmd([[
hi link VirtColumn Comment
let g:python_highlight_all = 1
]])


-- Status Bar
local lg_lualine_theme = require'lualine.themes.OceanicNext'
local b_bg = '#565e76'
local c_bg = '#363b4a'

lg_lualine_theme.normal.a.bg = '#2760c9'
lg_lualine_theme.insert.a.bg = '#27ce34'
lg_lualine_theme.visual.a.bg = '#f7981f'

lg_lualine_theme.normal.b.bg = b_bg
lg_lualine_theme.insert.b.bg = b_bg
lg_lualine_theme.visual.b.bg = b_bg
lg_lualine_theme.replace.b.bg = b_bg
lg_lualine_theme.inactive.b.bg = b_bg
lg_lualine_theme.normal.c.bg = c_bg
lg_lualine_theme.insert.c.bg = c_bg
lg_lualine_theme.visual.c.bg = c_bg
lg_lualine_theme.replace.c.bg = c_bg
lg_lualine_theme.inactive.c.bg = c_bg

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = lg_lualine_theme,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_c = { 'filename' },
    lualine_z = { 'location' }
  },
}

-- Tab Line
require('bufferline').setup {
    options = {
        mode = "tabs",
        numbers = "ordinal",
        separator_style = "slant",
        close_icon = '',
        buffer_close_icon = '',
        color_icons = true,
        offsets = {
            {filetype = "NvimTree", text = "Files", highlight = "Directory", text_align = "left"}
        },
    }
}

-- File Tree
require('nvim-tree').setup({
    open_on_tab = true,
    update_cwd = true,
})
