vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.cursorline = true
vim.opt.statusline = '2'
vim.opt.showmode = false
vim.opt.wildmenu = true
vim.opt.eb = false
vim.opt.cmdheight = 2

vim.opt.expandtab = true
vim.opt.ts = 4
vim.opt.sw = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.cindent = true

vim.opt.mouse = 'a'
vim.opt.virtualedit = 'block,onemore'
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.switchbuf = 'useopen,usetab,newtab'

-- buffer
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.autowrite = true
vim.opt.confirm = true
vim.opt.autochdir = true

-- GUI
vim.cmd([[
set guifont=FiraCode\ Nerd\ Font\ Mono
]])

-- colorscheme
vim.g.colors_name = 'tokyonight-moon'
vim.opt.background = 'dark'

