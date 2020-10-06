-------------------------------------------------------------------------------
------------------------------------LSPSAGA------------------------------------
-------------------------------------------------------------------------------
local saga = require 'lspsaga'

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
        hover = ' ',
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



-------------------------------------------------------------------------------
-----------------------------------Completion----------------------------------
-------------------------------------------------------------------------------

local cmp = require'cmp'

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<C-j>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
          end
        end, { "i", "s" }),

        ["<C-k>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = strings[1]
        local source = ({
            buffer      = "[Buffer]",
            nvim_lsp    = "[LSP]",
            ultisnips   = "[UltiSnips]",
            nvim_lua    = "[Lua]",
            cmp_tabnine = "[TabNine]",
            look        = "[Look]",
            path        = "[Path]",
            spell       = "[Spell]",
            calc        = "[Calc]",
            emoji       = "[Emoji]"
        })[entry.source.name]
        if source ~= nil then
          kind.menu = "    "..source
        end
        -- kind.menu = "    (" .. strings[2] .. ")"..source

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

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})



-------------------------------------------------------------------------------
--------------------------------Language Servers-------------------------------
-------------------------------------------------------------------------------
-- Enable snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
        capabilities = capabilities
    }
    server:setup(opts)
end)

require'lspconfig'.lua_ls.setup {}

-------------------------------------------------------------------------------
------------------------------------Snippet------------------------------------
-------------------------------------------------------------------------------

