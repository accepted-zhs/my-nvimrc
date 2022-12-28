-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `lazy`

vim.g.mapleader = "\\"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

return require('lazy').setup({
    'folke/tokyonight.nvim',
    'lifepillar/vim-solarized8',
    'chriskempson/base16-vim',
    'sainnhe/sonokai',

    { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true } },
    "petertriho/nvim-scrollbar",
    { 'kdheepak/tabline.nvim', dependencies = { { 'nvim-lualine/lualine.nvim', lazy = true }, {'kyazdani42/nvim-web-devicons', lazy = true } } },

    {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    },
    {
    	"windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    {
        'goolord/alpha-nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },
    'ryanoasis/vim-devicons',
    "lukas-reineke/indent-blankline.nvim",
    {
        'nvim-treesitter/nvim-treesitter',
        cmd = 'TSUpdate'
    },

    'simnalamburt/vim-mundo',
    { 'CRAG666/code_runner.nvim', dependencies = 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim', dependencies = { {'nvim-lua/plenary.nvim'} } },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    },
    'tpope/vim-fugitive',

    -- LSP
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
    { "glepnir/lspsaga.nvim", branch = "main" }, -- LSP UI
    'p00f/clangd_extensions.nvim', -- Clangd extensions
})

