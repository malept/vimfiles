augroup rust
  autocmd!
  autocmd BufWritePre *.rs undojoin | Neoformat
  " for racer
  autocmd BufNewFile,BufReadPost *.rs setl hidden
augroup END
