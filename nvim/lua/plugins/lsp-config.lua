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
        dependencies = {
            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            require("neodev").setup({})
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            lspconfig.tsserver.setup({
                capabilities = capabilities
            })
            lspconfig.clangd.setup({})
            lspconfig.gopls.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.bashls.setup({})
            lspconfig.html.setup({})
            lspconfig.cssls.setup({})
            lspconfig.yamlls.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.marksman.setup({})

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function (event)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
                    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references)
                    vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations)
                    vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions)
                    vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols)
                    vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_workspace_symbols)
                    vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})

                    -- higlight references when hold cursor on something
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references
                        })
                    end
                end
            })
        end
    }
}
