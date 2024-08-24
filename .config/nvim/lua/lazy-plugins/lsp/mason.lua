return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function ()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        require("mason").setup()
        require("mason-lspconfig").setup()

        require("mason-lspconfig").setup_handlers {
            function (server_name) -- default handler
                require("lspconfig")[server_name].setup {}
            end,
        }
    end
}
