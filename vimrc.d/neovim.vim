if has('nvim')
  autocmd! BufWritePost * Neomake
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#omni#input_patterns = {}
  " <ESC> in a term goes back to the previous window
  " From: https://www.reddit.com/r/neovim/comments/3wqo0i/nvim_terminal/cxyca7m
  tnoremap <ESC> <C-\><C-n><C-w><C-p>
end
