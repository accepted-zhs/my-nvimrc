-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'lifepillar/vim-solarized8'
    use 'chriskempson/base16-vim'

    use {'vim-airline/vim-airline', 'vim-airline/vim-airline-themes'}
    use 'sainnhe/sonokai'
   
    use 'Raimondi/delimitMate'
    use 'mhinz/vim-startify'
    use 'ryanoasis/vim-devicons'
    use "lukas-reineke/indent-blankline.nvim"
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    
    use 'simnalamburt/vim-mundo'
    use 'skywind3000/asyncrun.vim'
    use {'Yggdroot/LeaderF', run = ':LeaderfInstallCExtension' }
    use 'preservim/nerdtree'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'tiagofumo/vim-nerdtree-syntax-highlight'
    use 'tpope/vim-fugitive'
--    use {'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()' }

    use {'neoclide/coc.nvim', branch = 'release'}

    if packer_bootstrap then
        require('packer').sync()
    end
end)

