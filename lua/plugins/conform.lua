local plugin = require('plugin_util')

return {
  plugin.not_vscode_plugin({'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_format" },
        rust = { "rustfmt" },
        sh = { "shellcheck", "shfmt" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
    end,
  })
}
