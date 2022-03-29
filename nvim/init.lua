require('ui')
require('plugins')
require('plugin-config/setup')
require('lsp')
require('keybindings')

-- ready to migrate
vim.cmd([[
""" NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>

""" Leaderf
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

""" vimtex
set conceallevel=1
let g:tex_conceal= 'abdmg'

let g:tex_flavor= 'latex'
let g:vimtex_compiler_latexmk_engines = {'_':'-xelatex'}

let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexmk'

let g:vimtex_toc_config = {
\ 'name' : 'TOC',
\ 'layers' : ['content', 'todo', 'include'],
\ 'split_width' : 25,
\ 'todo_sorted' : 0,
\ 'show_help' : 1,
\ 'show_numbers' : 1,
\}

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","

""" Async Single File Compile & Run
" let g:asyncrun_open = 6

func! CompileFile()
    let opts = {"cwd": $VIM_FILEPATH, "mode": "term", "rows": 8, "focus": 0}
    if &filetype == 'cpp'
        call asyncrun#run("!", opts, "g++ \"$VIM_FILEPATH\" -o \"$VIM_PATHNOEXT\" -Wall -Wextra -std=c++14 -g -DLOCAL")
    elseif &filetype == 'c'
        call asyncrun#run("!", opts, "gcc \"$VIM_FILEPATH\" -o \"$VIM_PATHNOEXT\" -Wall -Wextra")
    endif
endfunc

func! RunFile()
    call asyncrun#stop("")
    let opts = {"cwd": $VIM_FILEPATH, "mode": "term", "rows": 8}
    if &filetype == 'cpp' || &filetype == 'c'
        call asyncrun#run("!", opts, "time \"$VIM_PATHNOEXT\"")
    elseif &filetype == 'python'
        call asyncrun#run("!", opts, "python3 -u \"$VIM_FILEPATH\"")
    elseif &filetype == 'sh'
        call asyncrun#run("!", opts, "bash \"$VIM_FILEPATH\"")
    endif
endfunc

nnoremap <F5> :call CompileFile()<CR>
nnoremap <F6> :call RunFile()<CR>

if filereadable(expand("~/.vimrc_custom_settings"))
    source ~/.vimrc_custom_settings
endif
]])

