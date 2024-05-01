return {
    'mhartington/formatter.nvim',
    config = function()
        local function prettier()
            return {
                exe = 'prettier',
                args = {
                    '--config-precedence',
                    'prefer-file',
                    '--single-quote',
                    '--no-bracket-spacing',
                    '--arrow-parens',
                    'always',
                    '--trailing-comma',
                    'all',
                    '--no-semi',
                    '--end-of-line',
                    'lf',
                    '--print-width',
                    '120',
                    '--stdin-filepath',
                    vim.fn.shellescape(
                        vim.api.nvim_buf_get_name(
                            0
                        )
                    ),
                },
                stdin = true,
            }
        end

        -- Auto format on save
        local augroup =
            vim.api.nvim_create_augroup
        local autocmd =
            vim.api.nvim_create_autocmd
        augroup(
            '__formatter__',
            {
                clear = true,
            }
        )
        autocmd(
            'BufWritePost',
            {
                group = '__formatter__',
                command = ':FormatWrite',
            }
        )

        -- use prettier
        require(
            'formatter'
        ).setup({
            logging = false,
            filetype = {
                javascript = {
                    prettier,
                },
                typescript = {
                    prettier,
                },
                ['javascript.jsx'] = {
                    prettier,
                },
                ['typescript.tsx'] = {
                    prettier,
                },
                markdown = {
                    prettier,
                },
                css = {
                    prettier,
                },
                json = {
                    prettier,
                },
                jsonc = {
                    prettier,
                },
                scss = {
                    prettier,
                },
                yaml = {
                    prettier,
                },
                graphql = {
                    prettier,
                },
                html = {
                    prettier,
                },
                rust = {
                    function()
                        return {
                            exe = 'rustfmt',
                            args = {
                                '--emit=stdout',
                            },
                            stdin = true,
                        }
                    end,
                },
                python = {
                    function()
                        return {
                            exe = 'black',
                            args = {
                                '--quiet',
                                '-',
                            },
                            stdin = true,
                        }
                    end,
                },
                go = {
                    function()
                        return {
                            exe = 'gofmt',
                            stdin = true,
                        }
                    end,
                },
                lua = {
                    function()
                        return {
                            exe = 'stylua',
                            args = {
                                '--line-endings',
                                'Unix'
                            },
                            stdin = true,
                        }
                    end,
                },
            },
        })
    end,
}
