-- Color Scheme
local lg_monokai = {
    white  = '#F8F8F0',
    gray0  = '#AAADAF',
    gray1  = '#595959',
    gray2  = '#555657',
    black  = '#272822',
    red    = '#f92672',
    orange = '#fd971f',
    yellow = '#e6db74',
    green  = '#a6e22e',
    cyan   = '#66d9ef',
    blue   = '#217cdd',
    purple = '#ae81ff',
    bg0    = '#2c2f38',
    bg1    = '#22252e',
}

require('monokai').setup({
    palette = {
        name = 'monokai_lg',
        base1 = lg_monokai.bg0,
        base2 = lg_monokai.bg0, -- Background
        base3 = lg_monokai.bg1,
        base4 = lg_monokai.bg1, -- Curly Brackets and Hightlights
        base5 = lg_monokai.gray0, -- Numbering
        base6 = lg_monokai.gray2, -- Comments
        base7 = lg_monokai.gray0,
        white = lg_monokai.white,
        grey =  lg_monokai.gray1,
    },
})

-- Status Bar
local lg_lualine_theme = require('lualine.themes.OceanicNext')
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

-- Conflict with NvimTree: Already called
--require('nvim-web-devicons').setup()  -- must be set after <colorscheme> command

-- Highlights
vim.cmd(
"highlight IndentBlanklineChar guifg="..lg_monokai.gray2..
    " gui=nocombine".."\n"..
"highlight IndentBlanklineContextChar guifg="..lg_monokai.orange..
    " gui=nocombine".."\n"..
"highlight VirtColumn guifg="..lg_monokai.gray2..
    " guibg="..lg_monokai.bg0.." gui=nocombine".."\n"..
"highlight link DashboardHeader Type      ".."\n"..
"highlight link DashboardCenter Tag       ".."\n"..
"highlight link DashboardFooter Identifier".."\n"
)

-- Telescope
vim.cmd(
"highlight TelescopeResultsNormal guibg=#22252e guifg="..lg_monokai.yellow.."\n"..
"highlight TelescopeResultsBorder guibg=#22252e guifg="..lg_monokai.cyan  .."\n"..
"highlight TelescopeResultsTitle  guibg=#22252e guifg="..lg_monokai.white .."\n"..
"highlight TelescopePromptNormal  guibg=#22252e guifg="..lg_monokai.orange.."\n"..
"highlight TelescopePromptBorder  guibg=#22252e guifg="..lg_monokai.cyan  .."\n"..
"highlight TelescopePromptTitle   guibg=#22252e guifg="..lg_monokai.white .."\n"..
"highlight TelescopePreviewNormal guibg=#22252e guifg="..lg_monokai.white .."\n"..
"highlight TelescopePreviewBorder guibg=#22252e guifg="..lg_monokai.cyan  .."\n"..
"highlight TelescopePreviewTitle  guibg=#22252e guifg="..lg_monokai.white .."\n"
)

-- Saga
vim.cmd([[
highlight link LspSagaDiagnosticSource Tag
highlight link LspSagaDiagnosticBorder Type
highlight link LspSagaDiagnosticHeader Type
highlight link LspSagaCodeActionTitle Function
highlight link LspSagaCodeActionBorder Function
highlight link LspSagaCodeActionContent String
highlight link LSOutlinePreviewBorder Number
]])

-- Diagnostics
vim.cmd([[
sign define DiagnosticSignError text=  texthl=DiagnosticSignError
sign define DiagnosticSignWarn  text=  texthl=DiagnosticSignWarn
sign define DiagnosticSignInfo  text=  texthl=DiagnosticSignInfo
sign define DiagnosticSignHint  text=  texthl=DiagnosticSignHint
]])

-- Languages
vim.cmd([[
let g:python_highlight_all = 1
]])
