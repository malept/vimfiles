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

  if !exists('g:vscode')
    if has('nvim-0.5')
      lua require('lspcompletion')
      if has('nvim-0.6') && $NVIM_TREESITTER == 'yes'
        lua require('treesitter')
      endif
      " Recommended completion-nvim settings
      " * Use <Tab> and <S-Tab> to navigate through popup menu
      inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
      " * Set completeopt to have a better completion experience
      set completeopt=menuone,noinsert,noselect

      " * Avoid showing message extra message when using completion
      set shortmess+=c

    else
      " Deoplete
      let g:deoplete#enable_at_startup = 1
      "" Close the preview window after completion is done
      autocmd CompleteDone * pclose!

      " LanguageClient-neovim
      runtime! neovim/languageclient.vim
    endif

    if executable('gopls')
      " Disable gopls with vim-go
      let g:go_gopls_enabled = 0
    endif
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

  if has('nvim-0.4.0') && !exists("g:vscode")
    " https://github.com/norcalli/nvim-colorizer.lua/issues/30#issuecomment-619939313
    lua require('setupcolorizer')
  endif

  " neovim-fuzzy
  if executable('fzy')
    nnoremap <C-p> :FuzzyOpen<CR>
  endif

  " Terminal
  runtime! neovim/terminal.vim

  " From vim-sensible (left out of neovim defaults, see
  " https://github.com/neovim/neovim/issues/2676)
  set ruler
  "" Use <C-L> to clear the highlighting of :set hlsearch.
  if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
  endif
end
