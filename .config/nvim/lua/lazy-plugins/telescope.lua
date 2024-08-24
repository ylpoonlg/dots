return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = function ()
        require("telescope").setup {
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = require("telescope.actions").move_selection_next,
                        ["<C-k>"] = require("telescope.actions").move_selection_previous,
                    },
                },
            },
            pickers = {
                git_status = {
                    git_icons = {
                        changed = "",
                        added = "",
                        copied = "",
                        deleted = "",
                        renamed = "",
                        unmerged = "",
                        untracked = "",
                    },
                },
            },
        }

        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>tb", ":Telescope buffers<CR>", opts)
        vim.keymap.set("n", "<leader>tg", ":Telescope live_grep<CR>", opts)
        vim.keymap.set("n", "<leader>th", ":Telescope highlights<CR>", opts)
        vim.keymap.set("n", "<leader>tj", ":Telescope jumplist<CR>", opts)
        vim.keymap.set("n", "<leader>tk", ":Telescope keymaps<CR>", opts)
        vim.keymap.set("n", "<leader>tt", ":Telescope find_files<CR>", opts)
        vim.keymap.set("n", "gd",  ":Telescope lsp_definitions<CR>", opts)
        vim.keymap.set("n", "gr",  ":Telescope lsp_references<CR>", opts)
        vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", opts)
        vim.keymap.set("n", "<leader>gl", ":Telescope git_commits<CR>", opts)
        vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", opts)

        -- Highlights
        vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link="Structure" })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link="DiagnosticInfo" })
        vim.api.nvim_set_hl(0, "TelescopeResultsTitle",  { link="Ignore" })
        vim.api.nvim_set_hl(0, "TelescopePromptNormal",  { link="Statement" })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder",  { link="DiagnosticInfo" })
        vim.api.nvim_set_hl(0, "TelescopePromptTitle",   { link="Ignore" })
        vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { link="Ignore" })
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link="DiagnosticInfo" })
        vim.api.nvim_set_hl(0, "TelescopePreviewTitle",  { link="Ignore" })
    end
}
