require('plugins')
require('plugin-config/setup')
require('ui')
require('keybindings')

vim.cmd([[
if filereadable(expand("~/.vimrc_custom_settings"))
    source ~/.vimrc_custom_settings
endif
]])

