require('ui')
require('keybindings')
require('plugins')
require('plugin-config/setup')

vim.cmd([[
if filereadable(expand("~/.vimrc_custom_settings"))
    source ~/.vimrc_custom_settings
endif
]])

