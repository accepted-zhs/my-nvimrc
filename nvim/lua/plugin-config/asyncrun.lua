-- Async Single File Compile & Run
vim.g.asyncrun_open = 6

vim.cmd([[
func! CompileFile()
    let opts = {"cwd": $VIM_FILEPATH, "mode": "term", "pos": "right", "focus": 0, "cols": 40}
    if &filetype == 'cpp'
        call asyncrun#run("!", opts, "g++ \"$VIM_FILEPATH\" -o \"$VIM_PATHNOEXT\" -Wall -Wextra -std=c++14 -g -DLOCAL")
    elseif &filetype == 'c'
        call asyncrun#run("!", opts, "gcc \"$VIM_FILEPATH\" -o \"$VIM_PATHNOEXT\" -Wall -Wextra")
    endif
endfunc

func! RunFile()
    call asyncrun#stop("")
    let opts = {"cwd": $VIM_FILEPATH, "mode": "term", "pos": "right", "cols": 40}
    if &filetype == 'cpp' || &filetype == 'c'
        call asyncrun#run("!", opts, "/usr/bin/time -f \"Time: %U s\\nMem: %M kiB\" \"$VIM_PATHNOEXT\"")
    elseif &filetype == 'python'
        call asyncrun#run("!", opts, "python3 -u \"$VIM_FILEPATH\"")
    elseif &filetype == 'sh'
        call asyncrun#run("!", opts, "bash \"$VIM_FILEPATH\"")
    endif
endfunc
]])
