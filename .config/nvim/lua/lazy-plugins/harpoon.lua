return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
        local harpoon = require("harpoon")
        local fzflua = require("fzf-lua")

        harpoon:setup({})

        local function harpoon_fzf_picker(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            -- Call fzf-lua with the prepared list
            fzflua.fzf_exec(file_paths, {
                prompt = 'Harpoon ❯ ',
                actions = {
                    ["enter"]  = FzfLua.actions.file_edit_or_qf,
                    ["ctrl-s"] = FzfLua.actions.file_split,
                    ["ctrl-v"] = FzfLua.actions.file_vsplit,
                    ["ctrl-t"] = FzfLua.actions.file_tabedit,
                },
            })
        end

        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }
        map("n", "<leader>hl", function() harpoon_fzf_picker(harpoon:list()) end, opts)
        map("n", "<leader>ha", function() harpoon:list():add() end, opts)
        map("n", "<leader>hr", function() harpoon:list():remove() end, opts)
        map("n", "<leader>hj", function() harpoon:list():next() end, opts)
        map("n", "<leader>hk", function() harpoon:list():prev() end, opts)
        map("n", "<leader>h1", function() harpoon:list():select(1) end, opts)
        map("n", "<leader>h2", function() harpoon:list():select(2) end, opts)
        map("n", "<leader>h3", function() harpoon:list():select(3) end, opts)
        map("n", "<leader>h4", function() harpoon:list():select(4) end, opts)
    end,
}
