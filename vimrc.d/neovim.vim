if has('nvim')
  " Needed so that locally installed dictionaries work
  set rtp+=~/.local/share/nvim/site

  " inccommand (AKA live substitution)
  if exists('&inccommand')
    if has('nvim-0.3')
      set inccommand=split
    else
      " https://github.com/neovim/neovim/issues/5584
      set inccommand=nosplit
    endif
  endif
  " Deoplete
  let g:deoplete#enable_at_startup = 1
  "" Close the preview window after completion is done
  autocmd CompleteDone * pclose!

  " LanguageServer
  let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ }
  if executable('javascript-typescript-langserver')
    let g:LanguageClient_serverCommands.javascript = ['tcp://localhost:2089']
    let g:LanguageClient_serverCommands.typescript = ['tcp://localhost:2089']
  endif
  if executable('css-languageserver')
    let g:LanguageClient_serverCommands.css = ['tcp://localhost:2090']
  endif
  if executable('html-languageserver')
    let g:LanguageClient_serverCommands.html = ['tcp://localhost:2091']
  endif
  if executable('json-languageserver')
    let g:LanguageClient_serverCommands.json = ['tcp://localhost:2092']
  endif
  if executable('solargraph')
    let g:LanguageClient_serverCommands.ruby = ['tcp://localhost:7658']
  endif
  let g:LanguageClient_autoStart = 1
  let g:LanguageClient_signColumnAlwaysOn = 0
  nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

  if executable('gopls')
    let g:LanguageClient_serverCommands.go = ['gopls']
    " Disable gopls with vim-go
    let g:go_gopls_enabled = 0
  endif

  " neovim-remote
  if executable('nvr')
    let $EDITOR = 'nvr -cc split --remote-wait'
  else
    let $EDITOR = 'nvim'
  endif

  " python-neovim
  let _venv_python2 = expand('~/.local/share/virtualenv/neovim')
  let _venv_python3 = expand('~/.local/share/virtualenv/neovim3')
  if isdirectory(_venv_python2)
    let g:python_host_prog = _venv_python2 . "/bin/python"
  endif
  if isdirectory(_venv_python3)
    let g:python3_host_prog = _venv_python3 . "/bin/python"
  endif
  unlet _venv_python2 _venv_python3

  if has('nvim-0.4.0')
    lua require'colorizer'.setup()
  endif

  " neovim-fuzzy
  if executable('fzy')
    nnoremap <C-p> :FuzzyOpen<CR>
  endif

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
  "" Shortcut for :tabnew | term
  map <Leader>tt :tabnew \| terminal<CR>
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
