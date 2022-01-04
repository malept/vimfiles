-- For vim-test
vim.api.nvim_set_keymap('n', '<Leader>t', ':TestNearest<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>T', ':TestFile<CR>', { silent = true })

vim.api.nvim_set_var('test#strategy', 'neovim')
