local plugin = require("plugin_util")

local setup = function()
  local npairs = require("nvim-autopairs")
  npairs.setup({
    check_ts = true,
  })

  npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
  npairs.add_rules(require("nvim-autopairs.rules.endwise-ruby"))
end

return {
  plugin.not_vscode_plugin({
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    dependencies = {
      "Saghen/blink.cmp",
    },
    config = setup,
  }),
}
