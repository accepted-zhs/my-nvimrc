vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.cursorline = true
vim.opt.statusline = '2'
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

-- colorscheme
vim.g.colors_name = 'base16-onedark'
vim.opt.background = 'dark'
vim.g.airline_theme = 'onedark'
vim.cmd([[
hi Normal ctermfg=252 ctermbg=None
]])
