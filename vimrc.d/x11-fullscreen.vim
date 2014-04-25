if has("gui_running") && has("unix")
  " From http://gniourf-gniourf.blogspot.fr/2011/11/true-full-screen-for-gvim.html
  " Unknown license.
  function! ToggleFullScreen()
    call system("wmctrl -i -r ".v:windowid." -b toggle,fullscreen")
    redraw
  endfunction

  nnoremap <S-F11> :call ToggleFullScreen()<CR>
  inoremap <S-F11> <C-\><C-O>:call ToggleFullScreen()<CR>
endif
