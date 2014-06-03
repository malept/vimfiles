" Originally from: http://vim.wikia.com/wiki/User:Tonymec/vimrc
" Ctrl-K comma colon (in Insert mode): UTF-8 single-codepoint ellipsis "..."
" disregard error if (for instance) not in UTF-8
if has("digraphs")
  silent!	dig	,:	8230 " HORIZONTAL ELLIPSIS
endif
