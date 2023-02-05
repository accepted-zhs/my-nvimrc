vim.cmd([[
let g:asynctasks_rtp_config = "tasks.ini"
let g:asynctasks_term_pos = 'right'
let g:asynctasks_term_rows = 10
let g:asynctasks_term_cols = 54
let g:asynctasks_profile = 'debug'
let g:asynctasks_term_focus = 0
]])

vim.keymap.set('n', '<F5>', ':AsyncTask file-build<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<F6>', ':AsyncTask file-run<CR>', { noremap = true, silent = false })

