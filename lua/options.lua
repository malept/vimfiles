-- code style
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.number = true -- line numbers
vim.opt.smartindent = true
vim.opt.formatoptions = 'tcroqn' -- see :help fo-table for option explanations

vim.opt.modeline = true
vim.opt.hlsearch = true

-- omnicompletion
vim.api.nvim_create_autocmd('Filetype', { callback = function() vim.opt_local.omnifunc = 'v:lua.vim.lsp.omniufnc' end })

-- # Directories
-- From: https://bitbucket.org/sjl/dotfiles/src/e6f6389e598f/vim/vimrc#cl-198
vim.opt.undodir = vim.fn.expand('~/.local/share/vim/undo/')
vim.opt.backupdir = vim.fn.expand('~/.local/share/vim/backup/')
-- ## Swap files
vim.opt.directory = vim.fn.expand('~/.local/share/vim/swap/')

-- ## Session directory for vim-prosession
vim.g.prosession_dir = vim.fn.expand('~/.local/share/vim/session/')

-- ## Make the folders automatically if they don't already exist.
local dirs = {
  vim.opt.undodir:get()[1],
  vim.opt.backupdir:get()[1],
  vim.opt.directory:get()[1],
  vim.g.prosession_dir
}
for _, dir in ipairs(dirs) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

-- Recommended by nvim-cmp
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- # EX command customization
vim.opt.wildmode = { 'longest', 'list', 'full' }

-- Theme
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- Redraw via keyboard shortcut
vim.keymap.set('', '<Leader>r', function() vim.cmd.redraw({ bang = true }) end, { desc = "Redraw screen" })

vim.opt.title = true

-- Console mouse support
vim.opt.mouse = 'a'

-- Character indicators
vim.opt.list = true
vim.opt.listchars = { tab = '» ', nbsp = '⎵' }

-- .env* files
vim.api.nvim_create_autocmd(
  { 'BufRead', 'BufNewFile' },
  { pattern = { '.env-*', '.env.*' }, callback = function() vim.cmd.setfiletype('sh') end }
)

-- editorconfig
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' }

-- Python
local py_group = vim.api.nvim_create_augroup('python', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
  pattern = '*.py',
  group = py_group,
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end
})
vim.g.poetv_executables = {'poetry'}

-- SQL
vim.g.sql_type_default = 'postgresql'

-- Shell
vim.g.is_bash = 1

-- Make current file executable
vim.keymap.set('', '<Leader>X', [[ !chmod +x %<CR> ]])

-- Ensure that locally installed dictionaries work
vim.opt.runtimepath:append('~/.local/share/nvim/site')

-- inccommand AKA live substitution
vim.opt.inccommand = 'split'

-- neovim-remote
if vim.fn.executable('nvr') == 1 then
  vim.env.EDITOR = 'nvr -cc split --remote-wait'
else
  vim.env.EDITOR = 'nvim'
end

-- python-neovim
local function setup_pynvim(python_bin, venv_dir)
  if vim.fn.isdirectory(venv_dir) == 1 then
    vim.g[string.format('%s_host_prog', python_bin)] = string.format('%s/bin/%s', venv_dir, python_bin)
  end
end
setup_pynvim('python', vim.fn.expand('~/.local/share/virtualenv/neovim'))
setup_pynvim('python3', vim.fn.expand('~/.local/share/virtualenv/neovim3'))
