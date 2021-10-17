augroup rust
  autocmd!
  if !exists('g:vscode') && (!has('nvim-0.6') || $NVIM_TREESITTER != 'yes')
    autocmd BufWritePre *.rs undojoin | Neoformat
  endif
  " for racer
  autocmd BufNewFile,BufReadPost *.rs setl hidden
augroup END
