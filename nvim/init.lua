require('ui')
require('plugins')
require('plugin-config/setup')
require('keybindings')

-- ready to migrate
vim.cmd([[
if filereadable(expand("~/.vimrc_custom_settings"))
    source ~/.vimrc_custom_settings
endif
]])

