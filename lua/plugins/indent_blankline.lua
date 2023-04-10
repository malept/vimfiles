local plugin = require('plugin_util')

local setup = function()
  require('indent_blankline').setup {
      space_char_blankline = ' ',
      show_current_context = true,
      show_current_context_start = true,
      buftype_exclude = {"terminal"},
  }
end

return {
  plugin.not_vscode_plugin({'lukas-reineke/indent-blankline.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = setup,
  }),
}
