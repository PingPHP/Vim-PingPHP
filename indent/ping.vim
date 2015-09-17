"初步想法是利用map去检测键盘输入
"然后拿到当前行号，向上检测，看是否为上一行续行，是否为空行（包含单行注释），否为多行注释
"
"所有结束条件是已经到了第0行，则缩进为0，如果不是第零行则刨去最后的注释后看最后面是否有冒号，则用indent()计算当前的indent数目加上冒号数，作为下一行的缩进数。
"
"空行就继续递归检测上一行
"续行就是检测一下上面一行的情况是否有\\n
"如果上面一行也有\\n则递归进行检测
"
"多行注释则向上去search对应的pattern然后再对应pattern行的上面一行去处理
"
func ping#nextline_indent_r(thisline)
    echo a:thisline
    return 4
endfunc

func ping#nextline_indent()
    let indent_num = ping#nextline_indent_r(line('.'))
    call setline(a:thisline, 'test')
    return indent_num
endfunc

"inoremap <CR> <C-O>:call ping#nextline_indent()<CR>
