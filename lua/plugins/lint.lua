local plugin = require('plugin_util')

return {
  plugin.not_vscode_plugin({'mfussenegger/nvim-lint',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        bash = { "shellcheck" },
        go = { "golangcilint" },
        lua = { "luacheck" },
        python = { "ruff" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end
  })
}
