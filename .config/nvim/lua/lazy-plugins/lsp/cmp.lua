return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        config = function ()
            local cmp = require("cmp")
            cmp.setup({
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({
                            mode = "symbol_text", maxwidth = 50
                        })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = strings[1]
                        local source = ({
                            nvim_lsp    = "[LSP]",
                            luasnip     = "[LUASNIP]",
                            buffer      = "[BUFFER]",
                            path        = "[PATH]",
                            cmdline     = "[CMD]",
                        })[entry.source.name]
                        if source ~= nil then
                            kind.menu = "    "..source
                        else
                            kind.menu = "    [" .. entry.source.name .. "]"
                        end
                        return kind
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered({
                        col_offset   = -3,
                        side_padding = 1,
                        winhighlight = "Normal:Type,FloatBorder:Tag",
                    }),
                    documentation = cmp.config.window.bordered(),
                },
            })

            cmp.setup.cmdline("/", {
                sources = cmp.config.sources({
                    { name = "buffer" }
                })
            })

            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path" }
                }, {
                    { name = "cmdline" }
                })
            })
        end,
    },
}
