return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "tsserver",
                "eslint",
                "lua_ls",
                "rust_analyzer",
                "zls"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            if client.server_capabilities.inlayHintProvider then
                                vim.lsp.inlay_hint.enable(bufnr, true)
                            end
                        end
                    }
                end,
                ["zls"] = function ()
                    print("Open ZLS")
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        on_attach = function(_, bufnr)
                            vim.lsp.inlay_hint.enable(bufnr, true)
                        end,
                        capabilities = capabilities,
                        cmd = { "zls" },
                        warn_style = true,
                        zig_lib_path = "C:/Users/Deruy/.zig/lib",
                        filetypes = { "zig", "zir" },
                        root_dir = lspconfig.util.root_pattern("zls.json", "build.zig", ".git"),
                        single_file_support = true,
                    })
                end,
                ["eslint"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.eslint.setup({
                        on_attach = function(bufnr)
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = tonumber(bufnr),
                                command = "EslintFixAll",
                            })
                        end,
                        capabilities = capabilities,
                        completions = {
                            completeFunctionCalls = true,
                        },
                    })
                end,
                ["tsserver"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.tsserver.setup({
                        on_attach = function(_, bufnr)
                            vim.lsp.inlay_hint.enable(bufnr, true)
                        end,
                        capabilities = capabilities,
                        single_file_support = true,
                        completions = {
                            completeFunctionCalls = true,
                        },
                        settings = {
                            javascript = {
                                inlayHints = {
                                    includeInlayEnumMemberValueHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayVariableTypeHints = false,
                                },
                            },

                            typescript = {
                                inlayHints = {
                                    includeInlayEnumMemberValueHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayVariableTypeHints = false,
                                },
                            },
                        },
                    })
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true })
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end

}
