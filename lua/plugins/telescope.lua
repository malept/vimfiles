local plugin = require('plugin_util')

local setup = function()
  require('telescope').load_extension('fzy_native')

  vim.api.nvim_set_keymap('n', '<C-p>', [[<Cmd>lua require('telescope_project_files').project_files{}<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>Gb', [[<Cmd>lua require('telescope.builtin').git_branches{}<CR>]], { noremap = true, silent = true })
end

return {
  plugin.not_vscode_plugin({'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
    },
    config = setup,
  }),
}
