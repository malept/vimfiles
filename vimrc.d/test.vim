" For vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>

if has('nvim')
  let test#strategy = "neovim"
else
  let test#strategy = "dispatch"
endif
