return {
    {
        "neovim/nvim-lspconfig",
    },
    {
        "williamboman/mason.nvim",
        config = function ()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function ()
            local keymap = vim.keymap
            local on_attach = function(_, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                -- some keybindings are disabled because of lspsaga.nvim
                keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                -- keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                -- keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
                -- keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                -- keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
                -- keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
            end
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("mason-lspconfig").setup({})
            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function (server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                    }
                end,
                ["lua_ls"] = function ()
                    require'lspconfig'.lua_ls.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                    version = 'LuaJIT',
                                },
                                diagnostics = {
                                    -- Get the language server to recognize the `vim` global
                                    globals = {'vim'},
                                },
                                workspace = {
                                    -- Make the server aware of Neovim runtime files
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                                -- Do not send telemetry data containing a randomized but unique identifier
                                telemetry = {
                                    enable = false,
                                },
                            },
                        }
                    }
                end
            }
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        config = function ()
            require('lsp_signature').setup({
                hint_prefix = "",
                close_timeout = 1000,
                -- floating_window_off_y = 10,
                transparency = 20, -- disabled by default, allow floating win transparent value 1~100
            })
        end
    },

    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-buffer',
    'L3MON4D3/LuaSnip',
    {
        'p00f/clangd_extensions.nvim',
        dependencies = {
            "williamboman/mason-lspconfig.nvim"
        },
        config = function ()
            require("clangd_extensions").setup({
                extensions = {
                    -- defaults:
                    -- Automatically set inlay hints (type hints)
                    autoSetHints = false,
                }
            })
        end
    },
    {
        'hrsh7th/nvim-cmp',
        config = function ()
            local luasnip = require 'luasnip'
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.recently_used,
                        require("clangd_extensions.cmp_scores"),
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
                }, {
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    },
    {
        'j-hui/fidget.nvim',
        config = function ()
            require("fidget").setup {}
        end
    },
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function ()
            require('lspsaga').setup {}
            local keymap = vim.keymap.set
            -- Lsp finder find the symbol definition implement reference
            -- if there is no implement it will hide
            -- when you use action in finder like open vsplit then you can
            -- use <C-t> to jump back
            keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

            -- Code action
            keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

            -- Rename
            keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

            -- Peek Definition
            -- you can edit the definition file in this flaotwindow
            -- also support open/vsplit/etc operation check definition_action_keys
            -- support tagstack C-t jump back
            keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

            -- Show line diagnostics you can pass arugment ++unfocus to make
            -- show_line_diagnsotic float window unfocus
            keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

            -- Show cursor diagnostic
            -- also like show_line_diagnostics  support pass ++unfocus
            keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

            -- Show buffer diagnostic
            keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

            -- Diagnsotic jump can use `<c-o>` to jump back
            keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
            keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

            -- Diagnostic jump with filter like Only jump to error
            keymap("n", "[E", function()
                require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
            end)
            keymap("n", "]E", function()
                require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
            end)

            -- Toglle Outline
            keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

            -- Hover Doc
            keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

            -- Callhierarchy
            keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
            keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

            -- Float terminal
            keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
        end,
    }
}
