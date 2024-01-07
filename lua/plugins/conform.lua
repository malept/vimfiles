local plugin = require("plugin_util")

return {
  plugin.not_vscode_plugin({
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      local vscode_settings = require("vscode_settings")

      local formatters = {}
      local vsc_settings = vscode_settings.load()
      if vsc_settings ~= nil then
        if vsc_settings["shellformat.path"] ~= nil then
          formatters.shfmt = {
            command = vscode_settings.expand(vsc_settings["shellformat.path"]),
          }
        end
        if vsc_settings["shellcheck.customArgs"] ~= nil then
          formatters.shellcheck = {
            prepend_args = vsc_settings["shellcheck.customArgs"],
          }
        end
      end

      require("conform").setup({
        formatters_by_ft = {
          go = { "goimports", "gofmt" },
          lua = { "stylua" },
          python = { "ruff_fix", "ruff_format" },
          rust = { "rustfmt" },
          sh = { "shellcheck", "shfmt" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters = formatters,
      })
    end,
    init = function()
      vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
    end,
  }),
}
