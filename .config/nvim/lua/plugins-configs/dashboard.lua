local home = os.getenv('HOME')

local function get_nvim_version()
    return vim.api.nvim_exec([[
        echo matchstr(execute('version'), 'NVIM v\zs[^\n]*')
    ]], true)
end
local function open_file_path (path, filename)
    return ':cd ' .. path .. ' | :e ' .. path .. filename
end

require('dashboard').setup {
  theme = 'doom',
  shortcut_type = 'letter',
  hide = {
    statusline = true,    -- hide statusline default is true
    tabline = true,       -- hide the tabline
    winbar = true,        -- hide winbar
  },
  preview = {
    command = 'cat | lolcat -F 0.08 -S 42 -a -d 1',
    file_path = home .. '/.config/nvim/preview_header.txt',
    file_height = 14,
    file_width = 62,
  },
  config = {
    center = {
      {icon = '  ',
      desc = 'Last Session  ',
      action = 'lua last_session()',
      shortcut = ''},
      {icon = '  ',
      desc = 'New File      ',
      action = 'DashboardNewFile',
      shortcut = ''},
      {icon = '  ',
      desc = 'Open A File   ',
      action = 'Telescope find_files',
      shortcut = ''},
      {icon = '  ',
      desc = 'Neovim Config ',
      shortcut = '',
      action = open_file_path(home..'/.config/nvim/',  'init.lua')},
      {icon = '  ',
      desc = 'Qtile Config  ',
      shortcut = '',
      action = open_file_path(home..'/.config/qtile/', 'config.py')},
      {icon = '  ',
      desc = 'Eww Config    ',
      shortcut = '',
      action = open_file_path(home..'/.config/eww/',   'eww.yuck')},
    },
    footer = {
      '',
      '',
      '',
      '',
      '',
      '[NVIM '..get_nvim_version()..']',
    },
  },
}


