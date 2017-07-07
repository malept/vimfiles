if has('nvim')
  " Needed so that locally installed dictionaries work
  set rtp+=~/.local/share/nvim/site

  " inccommand (AKA live substitution)
  if exists('&inccommand')
    " Can't do split until https://github.com/neovim/neovim/issues/5584
    " is fixed
    set inccommand=nosplit
  endif

  " Neomake
  autocmd! BufWritePost * Neomake
  if executable($PWD . "/node_modules/.bin/eslint")
    let g:neomake_javascript_eslint_exe = $PWD . "/node_modules/.bin/eslint"
  endif

  " Deoplete
  let g:deoplete#enable_at_startup = 1
  "" Close the preview window after completion is done
  autocmd CompleteDone * pclose!

  " LanguageServer
  let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ }
  let g:LanguageClient_autoStart = 1
  let g:LanguageClient_signColumnAlwaysOn = 0
  nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

  " python-neovim
  let g:python_host_prog = $HOME . "/.local/share/virtualenv/neovim/bin/python"
  let g:python3_host_prog = $HOME . "/.local/share/virtualenv/neovim3/bin/python"

  " neovim-fuzzy
  nnoremap <C-p> :FuzzyOpen<CR>

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
  "" Disable line numbers
  autocmd TermOpen * setlocal nonumber

  " From vim-sensible (left out of neovim defaults, see
  " https://github.com/neovim/neovim/issues/2676)
  set ruler
  "" Use <C-L> to clear the highlighting of :set hlsearch.
  if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
  endif
end
