-- Configuration specific to https://github.com/asvetliakov/vscode-neovim
for _, mtype in pairs({'x', 'n', 'o'}) do
  vim.api.nvim_set_keymap(mtype, 'gc', '<Plug>VSCodeCommentary', {})
end
vim.api.nvim_set_keymap('n', 'gcc', '<Plug>VSCodeCommentaryLine', {})
