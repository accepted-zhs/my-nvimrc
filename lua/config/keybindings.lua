local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

vim.cmd([[
vnoremap <leader><leader>y "+y<CR>
nnoremap <leader><leader>p "+p<CR>
nnoremap <leader>c :e $MYVIMRC<CR>
nnoremap <leader>cc :e ~/.vimrc_custom_settings<CR>
nnoremap <leader>s :source $MYVIMRC<CR>
nnoremap <C-a> G$vgg0
]])

