if !has("gui_running")
  set mouse=a
  if !has('nvim')
    " From: http://usevim.com/2014/08/11/script-roundup/
    set ttyfast
    set ttymouse=xterm2
  endif
endif
