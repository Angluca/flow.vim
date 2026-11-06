#### Vim plugin for flow language
https://flooooooooooow.github.io/flow/

Install using [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'yegappan/lsp'
Plug 'angluca/flow.vim'
```
Set lsp if you want
```vim
g:lsp_options = {
    outlineOnRight: true,
    outlineWinSize: 30,
    autoComplete: true,
    incrementalSync: true,
    snippetSupport: false,
    vsnipSupport: true,
    filterCompletionDuplicates: true,
}

def g:MyLspSetup()
  g:LspOptionsSet(g:lsp_options)
  g:LspAddServer([
    { name: 'flow', filetype: ['flow'], path: exepath('flow-lsp') },
  ])
enddef
au User LspSetup call g:MyLspSetup()
```
