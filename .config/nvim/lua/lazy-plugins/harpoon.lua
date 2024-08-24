return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
        local harpoon = require("harpoon")
        harpoon:setup({})

        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }
        map("n", "<leader>hl", function() toggle_telescope(harpoon:list()) end, opts)
        map("n", "<leader>ha", function() harpoon:list():append() end, opts)
        map("n", "<leader>hr", function() harpoon:list():remove() end, opts)
        map("n", "<leader>hj", function() harpoon:list():next() end, opts)
        map("n", "<leader>hk", function() harpoon:list():prev() end, opts)
        map("n", "<leader>h1", function() harpoon:list():select(1) end, opts)
        map("n", "<leader>h2", function() harpoon:list():select(2) end, opts)
        map("n", "<leader>h3", function() harpoon:list():select(3) end, opts)
        map("n", "<leader>h4", function() harpoon:list():select(4) end, opts)
    end,
}
