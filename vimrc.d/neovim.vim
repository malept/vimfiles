if has('nvim')
  " Needed so that locally installed dictionaries work
  set rtp+=~/.local/share/nvim/site

  " Neomake
  autocmd! BufWritePost * Neomake

  " Deoplete
  let g:deoplete#enable_at_startup = 1
  "" Close the preview window after completion is done
  autocmd CompleteDone * pclose!

  " python-neovim
  let g:python_host_prog = $HOME . "/.local/share/virtualenv/neovim/bin/python"
  let g:python3_host_prog = $HOME . "/.local/share/virtualenv/neovim3/bin/python"

  " Terminal
  "" Max out the terminal scrollback buffer
  let g:terminal_scrollback_buffer_size = 100000
  "" <ESC> in a term goes back to the previous window
  "" From: https://www.reddit.com/r/neovim/comments/3wqo0i/nvim_terminal/cxyca7m
  tnoremap <ESC> <C-\><C-n><C-w><C-p>
  "" Shortcut for :sp | term
  map <Leader>st :split \| terminal<CR>
  "" Shortcut for :vsp | term
  map <Leader>vt :vertical split \| terminal<CR>
end
