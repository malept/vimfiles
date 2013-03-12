" Per https://github.com/hail2u/vim-css3-syntax/issues/9
runtime! syntax/css/*.vim
syn clear cssMediaBlock
syn region cssMediaBlock contained transparent matchgroup=cssBraces start='{' end='}' contains=TOP
