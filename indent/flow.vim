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
    let indp = indent(prevLineNum) 
    let indc = indent(currentLineNum) 
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
    "if prevLine =~ '\v[:].*;\s*(\#.*)?$'
        "return indp
    "endif

    if currentLine =~ '\v^\s*[)\]}]+\s*(\/\/.*)?$'
        return indc
    endif
    if prevLine =~ '\v^\s*break\s*(\/\/.*)?$'
        return indp - sw
    endif
    if prevLine =~ '\v([(\[{:])\s*(\/\/.*)?$'
        return indp + sw
    endif
    if prevLine =~ '\v([^(]&[^\[]&[^\{]&[^:])\s*$'
        return indp
    endif

    return cindent(a:lnum)
endf

