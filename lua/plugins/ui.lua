return {
    {
        "startup-nvim/startup.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("startup").setup { theme = "dashboard" }
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require("lualine").setup {
                options = {
                    theme = 'tokyonight'
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {
                        'location', {
                            'datetime',
                            style = "%Y/%m/%d %H:%M"
                        }
                    }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
            }
        end
    },
    {
        "willothy/nvim-cokeline",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local get_hex = require('cokeline/utils').get_hex
            local mappings = require('cokeline/mappings')

            local comments_fg = get_hex('Comment', 'fg')
            local errors_fg = get_hex('DiagnosticError', 'fg')
            local warnings_fg = get_hex('DiagnosticWarn', 'fg')

            local red = vim.g.terminal_color_1
            local yellow = vim.g.terminal_color_3

            local components = {
                space = {
                    text = ' ',
                    truncation = { priority = 1 }
                },

                two_spaces = {
                    text = '  ',
                    truncation = { priority = 1 },
                },

                separator = {
                    text = function(buffer)
                        return buffer.index ~= 1 and '▏' or ''
                    end,
                    truncation = { priority = 1 }
                },

                devicon = {
                    text = function(buffer)
                        return
                        (mappings.is_picking_focus() or mappings.is_picking_close())
                        and buffer.pick_letter .. ' '
                        or buffer.devicon.icon
                    end,
                    fg = function(buffer)
                        return
                        (mappings.is_picking_focus() and yellow)
                        or (mappings.is_picking_close() and red)
                        or buffer.devicon.color
                    end,
                    style = function(_)
                        return
                        (mappings.is_picking_focus() or mappings.is_picking_close())
                        and 'italic,bold'
                        or nil
                    end,
                    truncation = { priority = 1 }
                },

                index = {
                    text = function(buffer)
                        return buffer.index .. ': '
                    end,
                    truncation = { priority = 1 }
                },

                unique_prefix = {
                    text = function(buffer)
                        return buffer.unique_prefix
                    end,
                    fg = comments_fg,
                    style = 'italic',
                    truncation = {
                        priority = 3,
                        direction = 'left',
                    },
                },

                filename = {
                    text = function(buffer)
                        return buffer.filename
                    end,
                    style = function(buffer)
                        return
                        ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
                        and 'bold,underline')
                        or (buffer.is_focused and 'bold')
                        or (buffer.diagnostics.errors ~= 0 and 'underline')
                        or nil
                    end,
                    truncation = {
                        priority = 2,
                        direction = 'left',
                    },
                },

                diagnostics = {
                    text = function(buffer)
                        return
                        (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
                        or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
                        or ''
                    end,
                    fg = function(buffer)
                        return
                        (buffer.diagnostics.errors ~= 0 and errors_fg)
                        or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
                        or nil
                    end,
                    truncation = { priority = 1 },
                },

                close_or_unsaved = {
                    text = function(buffer)
                        return buffer.is_modified and '●' or ''
                    end,
                    fg = function(buffer)
                        return buffer.is_modified and green or nil
                    end,
                    delete_buffer_on_left_click = true,
                    truncation = { priority = 1 },
                },
            }

            require('cokeline').setup({
                buffers = {
                    -- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
                    -- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
                    new_buffers_position = 'next',
                },

                default_hl = {
                    fg = function(buffer)
                        return
                        buffer.is_focused
                        and get_hex('Normal', 'fg')
                        or get_hex('Comment', 'fg')
                    end,
                    bg = get_hex('ColorColumn', 'bg'),
                },

                components = {
                    components.space,
                    components.separator,
                    components.space,
                    components.devicon,
                    components.space,
                    components.index,
                    components.unique_prefix,
                    components.filename,
                    components.diagnostics,
                    components.two_spaces,
                    components.close_or_unsaved,
                    components.space,
                },
            })

            local map = vim.keymap.set
            map('n', '<Leader>p', '<Plug>(cokeline-focus-prev)', { silent = true })
            map('n', '<Leader>n', '<Plug>(cokeline-focus-next)', { silent = true })
            for i = 1,9 do
                map('n', ('<Leader>%s'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i), { silent = true })
            end
        end
    },
    {
        "folke/noice.nvim",
        config = function ()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    signature = {
                        enabled = true,
                    }
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = true, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    {
        "petertriho/nvim-scrollbar",
        config = function ()
            require("scrollbar").setup {}
        end
    },
}
