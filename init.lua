local this_file = vim.fn.resolve(vim.fn.expand('<sfile>:p'))
local base_path = string.match(this_file, '^(.-)[^/\\]*$')

vim.opt.runtimepath:append(base_path)
package.path = ';' .. base_path .. 'lua/' .. package.path

require('001-packer')
require('clipboard')
require('reformatter')
if vim.fn.exists('g:vscode') == 0 then
  require('options')
  require('treesitter')
  require('lspcompletion')
  require('autopairs-config')
  require('telescope-config')
  require('setupcolorizer')
  require('terminal')
  require('vim-test')
else
  require('vscode')
end

vim.api.nvim_exec('runtime! vimrc.d/digraphs.vim', false)
