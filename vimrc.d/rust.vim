augroup rust
  autocmd!
  " for racer
  autocmd BufNewFile,BufReadPost *.rs setl hidden
augroup END

let g:racer_cmd = "multirust run stable racer"
