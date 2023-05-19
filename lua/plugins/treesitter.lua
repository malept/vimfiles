local plugin = require('plugin_util')

local setup = function()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "kotlin" }, -- List of parsers to ignore installing
    highlight = {
      enable = true,              -- false will disable the whole extension
      disable = {  },  -- list of language that will be disabled
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    -- TODO: remove once mini.comment has built-in support in a release
    context_commentstring = {
      enable = true
    },
  }
end

return {
  -- TODO: remove once mini.comment has built-in support in a release
  -- Remember to remove config = setup to treesitter plugin
  plugin.not_vscode_plugin({'JoosepAlviste/nvim-ts-context-commentstring',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = setup,
  }),
  plugin.not_vscode_plugin({'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'}),
}
