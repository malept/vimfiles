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

highlight TechWordsToAvoid ctermbg=red ctermfg=white

function MatchTechWordsToAvoid()
  match TechWordsToAvoid /\c\<\(obviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy\)\>/
endfunction

autocmd FileType markdown call MatchTechWordsToAvoid()
autocmd BufWinEnter *.md call MatchTechWordsToAvoid()
autocmd InsertEnter *.md call MatchTechWordsToAvoid()
autocmd InsertLeave *.md call MatchTechWordsToAvoid()
autocmd BufWinLeave *.md call clearmatches()

autocmd FileType rst call MatchTechWordsToAvoid()
autocmd BufWinEnter *.rst call MatchTechWordsToAvoid()
autocmd InsertEnter *.rst call MatchTechWordsToAvoid()
autocmd InsertLeave *.rst call MatchTechWordsToAvoid()
autocmd BufWinLeave *.rst call clearmatches()
