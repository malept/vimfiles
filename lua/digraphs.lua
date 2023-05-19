-- Vimscript version originally from: http://vim.wikia.com/wiki/User:Tonymec/vimrc
-- Ctrl-K comma colon (in Insert mode): UTF-8 single-codepoint ellipsis "..."
-- disregard error if (for instance) not in UTF-8
vim.cmd.digraphs({',:', '8230'}) -- HORIZONTAL ELLIPSIS
vim.cmd.digraphs({'?!', '8253'}) -- INTERROBANG
