" Make sure that the vimrc.d folder is visible to Vim
" Based on http://stackoverflow.com/a/15006790
"
" Grab the absolute, non-symlinked path of this file
let s:curfile = resolve(expand('<sfile>'))
" dirname()
let s:curfiledir = fnamemodify(s:curfile, ':h')
" append to runtimepath - syntax from vim-pathogen
let &rtp .= ',' . s:curfiledir
let &rtp .= ',' . s:curfiledir . '/vimrc.d'
unlet s:curfiledir
unlet s:curfile

" vimrc.d
runtime! vimrc.d/*.vim
