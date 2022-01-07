require('telescope').load_extension('fzy_native')

vim.api.nvim_set_keymap('n', '<C-p>', [[<Cmd>lua require('plugins.telescope_project_files').project_files{}<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>Gb', [[<Cmd>lua require('telescope.builtin').git_branches{}<CR>]], { noremap = true, silent = true })
