local plugin = require("plugin_util")

return {
  plugin.not_vscode_plugin({
    "mfussenegger/nvim-lint",
    dependencies = "L3MON4D3/LuaSnip",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      local vscode_settings = require("vscode_settings")
      local lint = require("lint")
      -- actionlint config from https://github.com/mfussenegger/nvim-lint/issues/660#issuecomment-2363077191
      vim.filetype.add({
        pattern = {
          [".*/.github/workflows/.*%.yml"] = "yaml.ghaction",
          [".*/.github/workflows/.*%.yaml"] = "yaml.ghaction",
        },
      })

      lint.linters_by_ft = {
        go = { "golangcilint" },
        lua = { "luacheck" },
        python = { "ruff" },
        sh = { "shellcheck" },
      }

      if vim.fn.executable("actionlint") == 1 then
        lint.linters_by_ft["ghaction"] = { "actionlint" }
      end

      local vsc_settings = vscode_settings.load()
      if vsc_settings ~= nil then
        local golangcilint = lint.linters.golangcilint
        if vsc_settings["go.alternateTools"] ~= nil and vsc_settings["go.alternateTools"]["golangci-lint"] ~= nil then
          golangcilint.cmd = vscode_settings.expand(vsc_settings["go.alternateTools"]["golangci-lint"])
        end
        local shellcheck = lint.linters.shellcheck
        if vsc_settings["bashIde.shellcheckPath"] ~= nil then
          shellcheck.cmd = vscode_settings.expand(vsc_settings["bashIde.shellcheckPath"])
        end
        if vsc_settings["shellcheck.customArgs"] ~= nil then
          shellcheck.args = vsc_settings["shellcheck.customArgs"]
        elseif vsc_settings["bashIde.shellcheckArguments"] ~= nil then
          shellcheck.args = vsc_settings["bashIde.shellcheckArguments"]
        end
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  }),
}
