local plugin = require('plugin_util')

local setup = function()
  local npairs = require('nvim-autopairs')
  npairs.setup({
    check_ts = true,
  })

  npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
  npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return {
  plugin.not_vscode_plugin({'windwp/nvim-autopairs',
    event = 'VeryLazy',
    dependencies = 'hrsh7th/nvim-cmp',
    config = setup,
  }),
}
