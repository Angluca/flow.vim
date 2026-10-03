if exists("b:did_indent")
    finish
endif
let b:did_indent = 1
if !has("cindent") || !has("eval")
    finish
endif

"setl cindent
setl expandtab
setl nolisp
"setlocal autoindent

setl cinoptions=Ls,l1,g0,t0,j1,J1,p0,)s,(s "(2s

setl indentkeys=o,O,0{,0},0],0),!^F ",!<Tab>
"setl cinwords=if,or,for,$each,$if,$or
setl indentexpr=GetFlowIndent(v:lnum)

let b:undo_indent = "setl cinoptions< indentexpr< indentkeys<"

fun! GetFlowIndent(lnum)
    let currentLineNum = a:lnum
    let currentLine = getline(a:lnum)

    let prevLineNum = prevnonblank(a:lnum-1)
    let prevLine = getline(prevLineNum)
    let ind = indent(prevLineNum) 
    let sw = shiftwidth()

    "if prevLine =~ '\v\($'
        "return ind
    "endif
    
    "if prevLine =~ '\v(([\(][^\)]*)|([\[][^\]]*)|([\{][^\}]*))(\#.*)?$'
        "return indent(prevLineNum) + sw
    "endif
    "if prevLine =~ '\v\S+\s*(\#.*)$'
        "return indent(prevLineNum)
    "endif

    "if currentLine =~ '\v\s*[)\]}]+\s*[;]?\s*(\#.*)?$'
        "return indent(prevLineNum) - sw
    "endif
  
    "if prevLine =~ '\v([^(]&[^\[]&[^\{]&[^:])+(\#.*)?$'
    if prevLine =~ '\v[:].*;\s*(\#.*)?$'
        return ind
    endif

    return cindent(a:lnum)
endf

