" Search docsets for something you type

"" search related docsets
nnoremap <Leader>d :Dasht<Space>

"" search ALL the docsets
nnoremap <Leader><Leader>d :Dasht!<Space>

" Search docsets for words under cursor

"" search related docsets
nnoremap <silent> <Leader>D :call Dasht([expand('<cWORD>'), expand('<cword>')])<Return>

"" search ALL the docsets
nnoremap <silent> <Leader><Leader>D :call Dasht([expand('<cWORD>'), expand('<cword>')], '!')<Return>

" selected text

"" search related docsets
vnoremap <silent> <Leader>D y:<C-U>call Dasht(getreg(0))<Return>

"" search ALL the docsets
vnoremap <silent> <Leader><Leader>D y:<C-U>call Dasht(getreg(0), '!')<Return>

" Related docsets

let g:dasht_filetype_docsets = {} " filetype => list of docset name regexp

let g:dasht_filetype_docsets['ruby'] = ['PostgreSQL']
let g:dasht_filetype_docsets['sls'] = ['Saltstack']
