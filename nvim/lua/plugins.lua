-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'lifepillar/vim-solarized8'
    use 'chriskempson/base16-vim'
    use 'folke/tokyonight.nvim'
    use 'sainnhe/sonokai'

    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}
    use 'nvim-tree/nvim-web-devicons'
    use {"petertriho/nvim-scrollbar" }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use {
    	"windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                -- config
            }
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }
    use 'ryanoasis/vim-devicons'
    use "lukas-reineke/indent-blankline.nvim"
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'skywind3000/asyncrun.vim'
    use 'skywind3000/asynctasks.vim'
    use { 'nvim-telescope/telescope.nvim', requires = {
            'nvim-lua/plenary.nvim',
            "debugloop/telescope-undo.nvim",
        }
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly', -- optional, updated every week. (see issue #1193)
    }
    use 'tpope/vim-fugitive'

    use { -- LSP
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        'hrsh7th/nvim-cmp', -- Autocompletion plugin
        'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
        'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-buffer',
        'L3MON4D3/LuaSnip', -- Snippets plugin
        "ray-x/lsp_signature.nvim",
        'p00f/clangd_extensions.nvim',
        'j-hui/fidget.nvim',
    }
    use {
        "glepnir/lspsaga.nvim", -- LSP UI
        branch = "main",
        config = function()
            require('lspsaga').setup({})
        end,
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)

