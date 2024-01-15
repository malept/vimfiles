local plugin = require("plugin_util")

local setup = function()
  local vscode = require("dap.ext.vscode")
  vscode.json_decode = require("luasnip.util.jsonc").decode
  vscode.load_launchjs()
  local debugpy_venv = vim.fn.expand("~/.local/share/virtualenv/debugpy")
  if vim.fn.isdirectory(debugpy_venv) then
    require('dap-python').setup(debugpy_venv .. "/bin/python")
  end
end

return {
  plugin.not_vscode_plugin({ "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "Dap UI" },
    },
  }),
  plugin.not_vscode_plugin({ "mfussenegger/nvim-dap",
    dependencies = {
      "L3MON4D3/LuaSnip", -- For the jsonc parser
      "mfussenegger/nvim-dap-python"
    },
    config = setup,
  }),
}
