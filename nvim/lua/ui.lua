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

-- bufferline
require'tabline'.setup {
    -- Defaults configuration options
    enable = true,
    options = {
        -- If lualine is installed tabline will use separators configured in lualine by default.
        -- These options can be used to override those settings.
        section_separators = {'', ''},
        component_separators = {'', ''},
        max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
        show_devicons = true, -- this shows devicons in buffer section
        show_bufnr = false, -- this appends [bufnr] to buffer section,
        show_filename_only = false, -- shows base filename only instead of relative path in filename
        modified_icon = "+ ", -- change the default modified icon
        modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
        show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
    }
}
vim.cmd[[
set guioptions-=e " Use showtabline in gui vim
set sessionoptions+=tabpages,globals " store tabpages and globals in session
]]

-- statusline
require('lualine').setup()

-- scrollbar
require("scrollbar").setup()

