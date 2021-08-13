let g:LanguageClient_serverCommands = {
      \ 'rust': ['rls'],
      \ }
if executable('javascript-typescript-langserver')
  let g:LanguageClient_serverCommands.javascript = ['tcp://localhost:2089']
  let g:LanguageClient_serverCommands.typescript = ['tcp://localhost:2089']
endif
if executable('css-languageserver')
  let g:LanguageClient_serverCommands.css = ['tcp://localhost:2090']
endif
if executable('html-languageserver')
  let g:LanguageClient_serverCommands.html = ['tcp://localhost:2091']
endif
if executable('json-languageserver')
  let g:LanguageClient_serverCommands.json = ['tcp://localhost:2092']
endif
if executable('solargraph')
  let g:LanguageClient_serverCommands.ruby = ['solargraph', 'stdio']
endif
if executable('gopls')
  let g:LanguageClient_serverCommands.go = ['gopls']
endif

let g:LanguageClient_autoStart = 1
let g:LanguageClient_signColumnAlwaysOn = 0
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
