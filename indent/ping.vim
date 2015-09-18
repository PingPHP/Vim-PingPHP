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

func ping#nextline_indent(line_num)
    let line_num = a:line_num
    while line_num > 1 && len(getline(line_num)) == 0
        let line_num -= 1
    endwhile
    return indent(line_num)
endfunc

func ping#set_nextline()
    let line_num = line('.')
    let indent_num = ping#nextline_indent(line_num)
    let indent_str = ''
    let indent_num_in = indent_num
    while indent_num_in > 0
        let indent_str .= ' '
        let indent_num_in -= 1
    endwhile
    call append(line_num , indent_str)
    call cursor(line_num+1, indent_num + 1)
endfunc

inoremap <CR> <Esc>:call ping#set_nextline()<CR>a
nnoremap o :call ping#set_nextline()<CR>a
