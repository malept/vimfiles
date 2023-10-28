local plugin = require('plugin_util')

return {
  plugin.not_vscode_plugin({'lukas-reineke/indent-blankline.nvim',
    event = { "BufReadPost", "BufNewFile" },
    main = 'ibl',
    opts = {
      space_char_blankline = ' ',
      show_current_context = true,
      show_current_context_start = true,
      buftype_exclude = {"terminal"},
    }
  }),
}
