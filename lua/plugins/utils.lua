return {
    'skywind3000/asynctasks.vim',
    'tpope/vim-fugitive',
    {
        'skywind3000/asyncrun.vim',
        config = function ()
            vim.cmd([[
                let g:asynctasks_rtp_config = "tasks.ini"
                let g:asynctasks_term_pos = 'right'
                let g:asynctasks_term_rows = 10
                let g:asynctasks_term_cols = 54
                let g:asynctasks_profile = 'debug'
                let g:asynctasks_term_focus = 0
            ]])

            vim.keymap.set('n', '<F5>', ':AsyncTask file-build<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<F6>', ':AsyncTask file-run<CR>', { noremap = true, silent = true })
        end
    },
    {
        'mbbill/undotree',
        config = function ()
            vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
        end
    },
    {
        'nvim-telescope/telescope.nvim', 
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function ()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', 'ff', builtin.find_files, {})
            vim.keymap.set('n', 'fg', builtin.live_grep, {})
            vim.keymap.set('n', 'fb', builtin.buffers, {})
            vim.keymap.set('n', 'fh', builtin.help_tags, {})
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        version = 'nightly',
        config = function() 
            require("nvim-tree").setup {}
            vim.keymap.set('n', "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
        end
    },
}
