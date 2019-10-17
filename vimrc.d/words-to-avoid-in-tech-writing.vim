" Highlight words to avoid in tech writing
" ========================================
"
" obviously, basically, simply, of course, clearly,
" just, everyone knows, However, So, easy
"
" http://css-tricks.com/words-avoid-educational-writing/
"
" Vim snippet originally from Wynn Netherland
" (License: unknown)
" Source URL: https://github.com/pengwynn/dotfiles/commit/12159ea2

function! MatchTechWordsToAvoid()
  highlight TechWordsToAvoid ctermbg=red ctermfg=white guibg=#ff0000 guifg=#ffffff
  2match TechWordsToAvoid /\c\<\(obviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy\)\>/
endfunction

augroup mtwta_md
  autocmd!
  autocmd FileType markdown call MatchTechWordsToAvoid()
  autocmd BufWinEnter,InsertEnter,InsertLeave *.md call MatchTechWordsToAvoid()
  autocmd BufWinLeave *.md call clearmatches()
augroup END

augroup mtwta_rst
  autocmd!
  autocmd FileType rst call MatchTechWordsToAvoid()
  autocmd BufWinEnter,InsertEnter,InsertLeave *.rst call MatchTechWordsToAvoid()
  autocmd BufWinLeave *.rst call clearmatches()
augroup END
