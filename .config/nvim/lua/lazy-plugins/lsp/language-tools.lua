return {
    "dart-lang/dart-vim-plugin",
    {
        "lervag/vimtex",
        lazy = false,
        init = function ()
            vim.cmd([[
                let g:vimtex_view_method = 'zathura'
                let g:vimtex_compiler_method = 'latexmk'
                let g:vimtex_compiler_latexmk = {
                    \ 'aux_dir' : './aux/',
                    \ 'out_dir' : './out/',
                    \ 'callback' : 1,
                    \ 'continuous' : 1,
                    \ 'executable' : 'latexmk',
                    \ 'hooks' : [],
                    \ 'options' : [
                    \   '-verbose',
                    \   '-file-line-error',
                    \   '-synctex=1',
                    \   '-interaction=nonstopmode',
                    \ ],
                    \}
                let g:vimtex_quickfix_mode = 2
                let g:vimtex_quickfix_open_on_warning = 0
                let g:vimtex_quickfix_autoclose_after_keystrokes = 2
            ]])
        end,
    },
    {
        "akinsho/flutter-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
        },
        config = true,
    },
    {
        "vim-python/python-syntax",
        config = function ()
            vim.cmd("let g:python_highlight_all = 1")
        end,
    },
    "elkowar/yuck.vim",
    "normen/vim-pio",
}
