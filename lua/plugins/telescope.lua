local plugin = require('plugin_util')

local setup = function()
  require('telescope').load_extension('fzy_native')

  vim.keymap.set('n', '<C-p>', function() require('telescope_project_files').project_files{} end, { silent = true })
  vim.keymap.set('n', '<Leader>Gb', function() require('telescope.builtin').git_branches{} end, { silent = true })
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
