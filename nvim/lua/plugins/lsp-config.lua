return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "tsserver",
                    "clangd",
                    "gopls",
                    "rust_analyzer",
                    "lua_ls",
                    "bashls",
                    "html",
                    "cssls",
                    "yamlls",
                    "jsonls",
                    "marksman",
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.tsserver.setup({})
            lspconfig.clangd.setup({})
            lspconfig.gopls.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.bashls.setup({})
            lspconfig.html.setup({})
            lspconfig.cssls.setup({})
            lspconfig.yamlls.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.marksman.setup({})

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {})
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
        end
    }
}
