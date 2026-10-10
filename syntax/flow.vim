if exists("b:current_syntax")
    finish
endif

syn keyword flowKeyword function fn trait impl effect extern const module export theorem assume therefore shader
syn keyword flowKeyword state param solver becomes reaches input output nerver connect unit
syn keyword flowKeyword method with always every evolves
syn keyword flowKeyword parallel handle distinct
syn keyword flowOperator and or not
syn keyword flowBoolean true false null
"syn keyword flowType i8 i16 i32 i64 i128 u8 u16 u32 u64 u128 f32 f64 bool string void array ptr vec

syn keyword flowKeyword let var val const static pub fun typedef
syn keyword flowKeyword export extern expect opaque embed register restrict
syn keyword flowKeyword impl alias volatile async rec uni ext def tag sel
syn keyword flowType bool array vec void string ptr span
"syn keyword flowType isize usize
syn keyword flowType int uint long ulong
syn keyword flowType float double f32 f64

syn keyword flowLabel default ref deref mut as
"syn keyword flowConstant true false null
syn keyword flowSComment assert
"syn keyword flowMacro std
"syn keyword flowSMacro print alignof typeof
"syn match flowSMacro '\v<(put|[e]?print|[e]?println||alignas|alignof|typeof|typeof_unequal)>'
"syn match flowAdded '\v<(new|[m]?alloc)>'
"syn match flowException '\v<(free)>'

syn keyword flowSelf self
syn keyword flowRepeat do while loop for in to step
syn keyword flowRepeat sort sortBy descending unique
syn keyword flowStatement break continue return
syn keyword flowConditional if or else elif match unless switch case
syn keyword flowInclude include link when

"syn keyword flowException throw try catch cast raw
"syn keyword flowPanic panic
"syn keyword flowSuper private

" -- shader
"syn match   flowKeyword  '\v<(uniform|instance|varying|var|vertex|fragment|in|out)>'
"syn match   flowType     '\v<(texture|texture2[Dd])>'
"syn match   flowType     '\v<bool[234]?>'
"syn match   flowType     '\v<int[234]?>'
"syn match   flowType     '\v<uint[234]?>'
"syn match   flowType     '\v<half[234]?>'
"syn match   flowType     '\v<float([234](x[234])?)?>'
"syn match   flowType     '\v<[dbui]?vec[234]>'
"syn match   flowType     '\v<vec[234][dbfhui]?>'
"syn match   flowType     '\v<mat[234](x[234]f)?>'
"syn match   flowType     '\v<(vec|mat|list)\ze\['

syn match flowPreProc   '[@]'
syn match flowSymbol    '[,;:\.]'
syn match flowOperator  '[\+\-\%=\/\^\&\*!?><\$|~]'
syn match flowConstant  '[{}\[\]()]'
syn match flowType      '\v\(@<=\s*\w+\ze(\[.*\])*\s*\*+\s*\)' " (type*)
syn match flowType      '\v\[@<=\s*\w+\ze(\[.*\])*\s*\*+\s*\]' " [type*]
syn match flowType      '\v<\w+_[tscemui]>'
syn match flowRepeat    '\v([^\.](\.|(-\>)))@<=\w\w*'
syn match flowMacro     '\v<[_]*\u[A-Z0-9_]*>'
syn match flowType      '\v<[_]*\u[A-Z0-9_]*[a-z]+\w*>'
syn match flowType      '\v\.?\zs<([iu][0-9]{1,3})?>'

syn match flowType      '\v<\w+>\ze(::|\<(\w+\s*(\<.*\>|\[.*\])?\s*[,]?\s*)*\>)' "foo<T>()
syn match flowFunc      '\v\w+\ze((\[[^=;]*\])|((::)?\<.*\>))*\s*\('

syn match flowException '\v(\W@<=[~*@!?^]+\ze[\(\[\{\<]*[-]?\w)|(\w@<=[!]+\ze\W)'
syn match flowType      '\v<[uif]\d+(x\d+)+>' "f64x6
syn match flowAdded     '\v^\s*<(test)\ze\s+'
syn match flowInclude   '\v<(import)'
syn match flowInclude   '\v^<(import).*'
syn match flowSComment  '\v[$@](\w+)'
"syn match flowType      '\v<(res|opt)\ze\s*\['
"syn match flowMacro     '\v^\s*\[.{-}\]'
"syn match flowType      '\v<(str)\ze\s*\('
""syn match flowSMacro    '\v<(reduce|deref|list)\ze\s*\('
"syn match flowLabel     '\v<(addr)\ze\s*\('
syn match flowLabel     '\v(\-\>)|(\|\>)'
syn match flowFunc      '\v(\|\>)@<=\s*\w\w*'

syn match flowInclude "\v^\s*(import)>" nextgroup=flowRepeat,flowString,flowSymbol skipwhite
syn match flowRepeat "\v\w+" contained nextgroup=flowString,flowSymbol,flowRepeat skipwhite
"syn match flowSymbol ":" contained nextgroup=flowString,flowRepeat skipwhite
"syn match flowString "\v(\w+\.)+" contained nextgroup=flowRepeat skipwhite
"syn match flowString "\v\s+<as>\s+" contained nextgroup=flowRepeat skipwhite
"syn match flowString "\v:\s*(\w+(\.\w+)*)" contained
syn match flowString "\v\s*(\w+(\.\w+)*)(\s+as\s+)*" contained

syn match flowConstant contained /\v[\<,\>]/
syn region flowConstantSpec
    \ oneline
    \ keepend
    \ contains=flowType,flowOperator,flowMacro,flowSComment,flowConstant,flowConstantSpec,flowNumber,flowFloat
    \ start=/\v\<\s*/
    \ end=/\v\s*\>/

"hi def flowSymbol ctermfg=DarkGray guifg=DarkGray
hi def link flowSMacro   SpecialComment
hi def link flowTitle    Title
hi def link flowAdded    Added
hi def link flowConstant Constant
hi def link flowBoolean Constant
hi def link flowSymbol   Changed
hi def link flowMacro    Macro
hi def link flowSComment SpecialComment
hi def link flowFunc     Function
hi def link flowTypedef  Changed
"hi def flowType ctermfg=DarkCyan guifg=DarkCyan
hi def link flowType     MoreMsg
"hi def flowSelf ctermfg=DarkMagenta guifg=DarkMagenta
hi def link flowSelf     Label
hi def link flowModeMsg  ModeMsg

syn match  flowSpecialCharError display contained +\\\([^0-7nrt\\'"]\|[xX]\x\{2}\)+
syn match  flowSpecialChar      contained "\\\([\"\\'ntr]\|[xX]\x\{2}\)"
syn match  flowCharacter        "'[^']*'" contains=flowSpecialChar,flowSpecialCharError
syn match  flowCharacter        "'\\''" contains=flowSpecialChar
syn match  flowCharacter        "'[^\\]'"

"syn region    flowString      matchgroup=flowString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=flowEscape,@Spell
syn region    flowString      matchgroup=flowString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell
syn region    flowString      matchgroup=flowString start=+`+ skip=+\\\\\|\\`+ end=+`+ contains=@Spell

syn match flowNumber "\v<[0-9_]+>"
syn match flowNumber "\v<0[xX][0-9a-fA-F_]+([iuIU]?[lL]?[0-9]{-,3})?>"
syn match flowNumber "\v<0[bB][01_]+([iuIU]?[lL]?[0-9]{-,3})?>"

syn match flowFloat  '\v<\.\d+([eE][+-]?\d+)?[fFdD]?>' display
syn match flowFloat  '\v<0x\x+(\.\x+)?[pP][+-]?\d+[fFdD]?>' display

" Integer literals
syn match flowInteger '\v(\.@1<!|\.\.)\zs<(0|[1-9]\d*)([eE][+-]?\d+)?([iuIU]?[lL]?[0-9]{-,3})?>' display
syn match flowInteger '\v(\.@1<!|\.\.)\zs<0b[01]+([iuIU]?[lL]?[0-9]{-,3})?>' display
syn match flowInteger '\v(\.@1<!|\.\.)\zs<0o\o+([iuIU]?[lL]?[0-9]{-,3})?>' display
syn match flowInteger '\v(\.@1<!|\.\.)\zs<0x\x+([iuIU]?[lL]?[0-9]{-,3})?>' display

syn match flowFloat   display "\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\|\.\)\@!"
syn match flowFloat   display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)\="
syn match flowFloat   display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f32\|f64\)\="
syn match flowFloat   display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)"

" Escape sequences
syn match flowEscape '\\[\\'"0abfnrtv]' contained display
syn match flowEscape '\v\\(x\x{2}|u\x{4}|U\x{8})' contained display
" Format sequences
syn match flowFormat '\v\{\d*(\%\d*|:([- +=befgoxX]|F[.2sESU]|\.?\d+|_(.|\\([\\'"0abfnrtv]|x\x{2}|u\x{4}|\x{8})))*)?}' contained contains=flowEscape display
syn match flowFormat '{{\|}}' contained display


hi def link flowPreProc               PreProc
hi def link flowSuper                 Title
"hi def link flowFloat                 Constant
hi def link flowFloat                 Underlined
hi def link flowInteger               Number
hi def link flowEscape                SpecialComment
hi def link flowFormat                SpecialChar

hi def link flowKeyword               Keyword
hi def link flowInclude               Include
hi def link flowLabel                 Label
hi def link flowConditional           Conditional
hi def link flowRepeat                Repeat
hi def link flowStatement             Statement
"hi def link flowType                  Type
hi def link flowNumber                Number
hi def link flowComment               Comment
hi def link flowOperator              Operator
hi def link flowCharacter             Character
hi def link flowString                String
hi def link flowTodo                  Todo
hi def link flowSpecial               Special
hi def link flowSpecialError          Error
hi def link flowSpecialCharError      Error
hi def link flowString                String
hi def link flowCharacter             Character
hi def link flowSpecialChar           SpecialChar
hi def link flowException             Exception
hi def link flowPanic                 Exception

syn match   flowTypedef "\h\w*" display contained
syn match   flowFunc "\h\w*" display contained
"syn keyword flowKeyword union struct enum type nextgroup=flowTypedef skipwhite skipempty
syn keyword flowKeyword flow union struct enum type capability represent analyze nextgroup=flowTypedef skipwhite
"syn keyword flowKeyword union nextgroup=flowTypedef skipwhite skipempty contained
syn keyword flowKeyword function nextgroup=flowFunc skipwhite
"syn keyword flowAdded test nextgroup=flowFunc skipwhite
"syn keyword flowTypedef asm nextgroup=flowRepeat skipwhite skipempty
syn keyword flowTodo contained TODO FIXME XXX NOTE
"syn region  flowComment  start="/\*" end="\*/" contains=flowTodo,@Spell
syn match   flowComment  '\v\#.*$' contains=flowTodo,@Spell
syn match   flowPreProc  '\v\#\[\w+.{-}\]'

" flowAsm
"hi def link flowAsmEntry Changed
"hi def link flowAsmMacro Macro
"hi def link flowAsmCmd SpecialComment
"hi def link flowAsmCall Changed
"hi def link flowAsmGoto Label

"syn keyword flowAsmMacro main contained containedin=ALLBUT,flowAsm
""syn keyword flowAsmCmd mov contained containedin=ALLBUT,flowAsm
"syn region flowAsm start=/\v[^#]?(^|\{)\s*asm\s+\w+\s*\{/
    "\ end=/\v((^|\{)\s*asm\s+\w+\s*\{[^}]*\})|(\s*\})\s*$/
    "\ contains=flowAsmEntry,flowAsmCmd,flowAsmCall,flowAsmMacro,flowAsmGoto,flowComment,flowConstant,flowSymbol,flowOperator,flowType,flowNumber,flowFloat,flowInteger
    "\ containedin=ALLBUT,flowAsm keepend
"syn match flowAsmEntry '\v\s*asm\s+' contained containedin=ALLBUT,flowAsm
"syn match flowAsmMacro /\v\s*asm\s+\w+/ contained containedin=ALLBUT,flowAsm
"syn match flowAsmMacro '\v<_\w+>' contained containedin=ALLBUT,flowAsm
"syn match flowAsmCmd '\v^\s+\.?\w+(\.\w+)*\s' contained containedin=ALLBUT,flowAsm
"syn match flowAsmCall '\v^\s+\.?\w+(\.\w+)*\s*$' contained containedin=ALLBUT,flowAsm
"syn match flowAsmGoto '\v^\s*\w+\ze:' contained containedin=ALLBUT,flowAsm


syn sync fromstart
let b:current_syntax = "flow"
