vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.cursorline = true
vim.opt.statusline = '3'
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.wildmenu = true
vim.opt.eb = false
vim.opt.cmdheight = 2
vim.wo.signcolumn = 'yes'

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

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.autowrite = true
vim.opt.confirm = true
vim.opt.autochdir = true
vim.opt.undofile = true
vim.opt.undodir = '/var/tmp/'

-- GUI 
vim.cmd[[
set guifont=FiraCode\ Nerd\ Font\ Mono
set guioptions-=e " Use showtabline in gui vim
set sessionoptions+=tabpages,globals " store tabpages and globals in session
]]
