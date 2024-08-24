function luasnip_config()
    local ls = require("luasnip")

    -- lazy_load from installed snippets (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()
    -- lazy_load custom snippets
    require("luasnip.loaders.from_vscode").lazy_load({ paths = "./custom-snippets" })

    vim.keymap.set({"i", "s"}, "<C-Enter>", function() ls.jump( 1) end, {silent = true})
end

return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = luasnip_config,
    },
    "saadparwaiz1/cmp_luasnip",
}
