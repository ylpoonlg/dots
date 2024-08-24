return {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function ()
        local saga = require("lspsaga")
        saga.setup({
            ui = {
                title = false,
                border = "rounded",
                winblend = 0,
                expand = "",
                collapse = "",
                code_action = " ",
                incoming = " ",
                outgoing = " ",
                hover = " ",
                kind = {},
            },
            symbol_in_winbar = {
                enable = true,
                separator = "  ",
                ignore_patterns={},
                hide_keyword = true,
                show_file = true,
                folder_level = 2,
                respect_root = false,
                color_mode = true,
            },
            outline = {
                win_position = "right",
                win_width = 30,
                show_detail = false,
                auto_preview = false,
                keys = {
                  jump = "<CR>",
                  expand_collapse = "u",
                  quit = "<ESC>",
                },
            },
            code_action = {
                keys = {
                  quit = "<ESC>",
                  exec = "<CR>",
                },
            },
        })

        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<S-k>",  ":Lspsaga hover_doc<CR>", opts)
        vim.keymap.set("n", "<leader>ol", ":Lspsaga outline<CR>", opts)
        vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
        vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

        -- Highlights
        vim.api.nvim_set_hl(0, "LspSagaDiagnosticSource",  { link="Tag" })
        vim.api.nvim_set_hl(0, "LspSagaDiagnosticBorder",  { link="Type" })
        vim.api.nvim_set_hl(0, "LspSagaDiagnosticHeader",  { link="Type" })
        vim.api.nvim_set_hl(0, "LspSagaCodeActionTitle",   { link="Function" })
        vim.api.nvim_set_hl(0, "LspSagaCodeActionBorder",  { link="Function" })
        vim.api.nvim_set_hl(0, "LspSagaCodeActionContent", { link="String" })
        vim.api.nvim_set_hl(0, "LSOutlinePreviewBorder",   { link="Number" })
        vim.cmd([[
            sign define DiagnosticSignError text=  texthl=DiagnosticSignError
            sign define DiagnosticSignWarn  text=  texthl=DiagnosticSignWarn
            sign define DiagnosticSignInfo  text=  texthl=DiagnosticSignInfo
            sign define DiagnosticSignHint  text=  texthl=DiagnosticSignHint
        ]])
    end,
}
