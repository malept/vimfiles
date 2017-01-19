if !has("gui_running")
  if !has('nvim')
    " From: http://usevim.com/2014/08/11/script-roundup/
    set mouse=a
    set ttyfast
    set ttymouse=xterm2
  endif
endif
