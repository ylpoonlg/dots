return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
        require("fzf-lua").setup {
            winopts = {
                preview = {
                },
            },
            keymap = {
                builtin = {
                  true, -- inherit from defaults
                  ["<C-d>"] = "preview-page-down",
                  ["<C-u>"] = "preview-page-up",
                },
                fzf = {
                  true, -- inherit from defaults
                  ["ctrl-d"] = "preview-page-down",
                  ["ctrl-u"] = "preview-page-up",
                },
            },
            fzf_colors = {
                true, -- inherit fzf colors
                ["fg"]          = { "fg", "Ignore" },
                ["bg"]          = { "bg", "Normal" },
                ["hl"]          = { "fg", "Structure" },
                ["fg+"]         = { "fg", "Normal" },
                ["bg+"]         = { "bg", "CursorLine" },
                ["hl+"]         = { "fg", "Statement" },
                ["border"]      = { "fg", "Comment" },
                ["info"]        = { "fg", "Comment" },
                ["marker"]      = { "fg", "Structure" },
                ["pointer"]     = { "fg", "Type" },
                ["prompt"]      = { "fg", "Type" },
                ["spinner"]     = { "fg", "Statement" },
                ["header"]      = { "fg", "Comment" },
                ["label"]       = { "fg", "Ignore" },
                ["query"]       = { "fg", "Normal" },
            },
            hls = {
                border          = "Comment",
                preview_border  = "Comment",
                title           = "Ignore",
                live_prompt     = "Comment",
                live_sym        = "Statement",
                tab_title       = "Structure",
                header_bind     = "Comment",
                header_text     = "Ignore",
            },
            files = {
                cwd_prompt = false,
            },
            grep = {
                rg_opts = "--column --line-number --no-heading --smart-case --color=always --colors='path:fg:0xff,0x8f,0x40' --colors='line:fg:0xe6,0xb6,0x73' --max-columns=4096 -e",
            },
        }

        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>tt", ":FzfLua files<CR>", opts)
        vim.keymap.set("n", "<leader>tg", ":FzfLua live_grep<CR>", opts)
        vim.keymap.set("n", "<leader>tb", ":FzfLua buffers<CR>", opts)
        vim.keymap.set("n", "<leader>th", ":FzfLua highlights<CR>", opts)
        vim.keymap.set("n", "<leader>tj", ":FzfLua jumps<CR>", opts)
        vim.keymap.set("n", "<leader>tk", ":FzfLua keymaps<CR>", opts)
        vim.keymap.set("n", "<leader>gb", ":FzfLua git_branches<CR>", opts)
        vim.keymap.set("n", "<leader>gl", ":FzfLua git_commits<CR>", opts)
        vim.keymap.set("n", "<leader>gs", ":FzfLua git_status<CR>", opts)
        vim.keymap.set("n", "gd",  ":FzfLua lsp_definitions<CR>", opts)
        vim.keymap.set("n", "gr",  ":FzfLua lsp_references<CR>", opts)
    end
}
