if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

compiler flow

" Formatting
"setl formatoptions+=croql/ formatoptions-=t
setl formatoptions+=crql formatoptions-=t

" Miscellaneous settings
setl comments=f:#[,:#
setl commentstring=#\ %s
setl iskeyword+=@-@
setl suffixesadd=.flow

let b:undo_ftplugin = 'setl cms< com< fo< isk< sua<'

" Follow the flow style guide by default.
if get(g:, 'flow_recommended_style', 1)
  setl expandtab
  setl shiftwidth=4
  setl softtabstop=4
  setl tabstop=4
  setl textwidth=80
  let b:undo_ftplugin .= ' et< sts< sw< ts< tw<'

  "let s:root = expand('<sfile>:p:h:h')
  "exe 'setl dict+='.s:root.'/dicts/flow.base.dict,'.s:root. '/dicts/flow.dict'
endif

fu! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+\r\?$//ge
    nohl
    exe "normal `z"
endf

" Auto delete trailing white_space if save.
if get(g:, 'flow_save_cls', 1)
  au BufWrite *.flow call DeleteTrailingWS()
endif

augroup flow.vim
  autocmd!
  " Highlight incorrect spacing by default.
  if get(g:, 'flow_space_error', 1)
    au InsertEnter * hi link flowSpaceError NONE
    au InsertLeave * hi link flowSpaceError Error
  endif
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: et sw=2 sts=2 ts=8
