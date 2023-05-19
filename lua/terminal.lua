-- Max out the terminal scrollback buffer
vim.g.terminal_scrollback_buffer_size = 100000

-- <ESC> in a term goes back to the previous window
-- From: https://www.reddit.com/r/neovim/comments/3wqo0i/nvim_terminal/cxyca7m
vim.keymap.set('t', '<ESC>', '<C-\\><C-n><C-w><C-p>')

local function term_shortcut(mapping, cmd_prefix)
  vim.keymap.set('', string.format('<Leader>%st', mapping), string.format(':%s | terminal<CR>', cmd_prefix))
end
term_shortcut('s', 'split')
term_shortcut('v', 'vertical split')
term_shortcut('t', 'tabnew')

-- Disable line numbers
vim.api.nvim_exec([[ autocmd TermOpen * setlocal nonumber ]], false)
