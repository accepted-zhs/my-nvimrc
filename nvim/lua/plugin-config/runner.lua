vim.cmd([[
func! CompileFile()
    let opts = {"cwd": $VIM_FILEPATH, "mode": "term", "cols": 54, "focus": 0, "pos": "right"}
    if &filetype == 'cpp'
        call asyncrun#run("!", opts, "g++ \"$VIM_FILEPATH\" -o \"$VIM_PATHNOEXT\" -DLOCAL -Wall -Wextra -std=c++14 -g3 -fsanitize=address,undefined")
    elseif &filetype == 'c'
        call asyncrun#run("!", opts, "gcc \"$VIM_FILEPATH\" -o \"$VIM_PATHNOEXT\" -Wall -Wextra")
    endif
endfunc

func! RunFile()
    call asyncrun#stop("")
    let opts = {"cwd": $VIM_FILEPATH, "mode": "term", "cols": 54, "pos": "right"}
    if &filetype == 'cpp' || &filetype == 'c'
        call asyncrun#run("!", opts, "/usr/bin/time -f \"user time: %U s\nreal time: %e s\nmemory: %M kb\" \"$VIM_PATHNOEXT\"")
    elseif &filetype == 'python'
        call asyncrun#run("!", opts, "python3 -u \"$VIM_FILEPATH\"")
    elseif &filetype == 'sh'
        call asyncrun#run("!", opts, "bash \"$VIM_FILEPATH\"")
    endif
endfunc
]])

vim.keymap.set('n', '<F5>', ':call CompileFile()<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<F6>', ':call RunFile()<CR>', { noremap = true, silent = false })
