function ping#indent_expr(lnum)
    let s:indent_ignore='^\s*$'
    let lnum = prevnonblank(a:lnum - 1)
    while lnum > 0 && getline(lnum) =~ s:indent_ignore
        let lnum = prevnonblank(lnum - 1)
    endwhile
    if lnum == 0
        return 0
    endif
    let prevline = getline(lnum)
    let indent = indent(lnum)
    if (prevline =~'^[^#:]\+:[^\\:]*\(#.*\)\?$')
        let indent = indent + &sw
    endif
    return indent
endfunction

set expandtab	
set tabstop=4
set softtabstop=4
set shiftwidth=4
    
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
vnoremap <space> zf

set indentexpr=ping#indent_expr(v:lnum)




