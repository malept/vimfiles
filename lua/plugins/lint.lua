local plugin = require('plugin_util')

local function vscode_expand(data)
  return string.gsub(data, "${workspaceFolder}", vim.fn.getcwd())
end

return {
  plugin.not_vscode_plugin({"mfussenegger/nvim-lint",
    dependencies = { "L3MON4D3/LuaSnip" }
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        bash = { "shellcheck" },
        go = { "golangcilint" },
        lua = { "luacheck" },
        python = { "ruff" },
      }

      vscode_settings_path = vim.fn.getcwd() .. "/.vscode/settings.json"
      local file = io.open(vscode_settings_path, "r")
      local vscode_settings = {}
      if file then
        local contents = file:read("*all")
        local jsonc = require("luasnip.util.jsonc")
        vscode_settings = jsonc.decode(contents)
        file:close()

        local golangcilint = lint.linters.golangcilint
        if vscode_settings["go.alternateTools"] ~= nil and vscode_settings["go.alternateTools"]["golangci-lint"] ~= nil then
          golangcilint.cmd = vscode_expand(vscode_settings["go.alternateTools"]["golangci-lint"])
        end
        local shellcheck = lint.linters.shellcheck
        if vscode_settings["shellcheck.customArgs"] ~= nil then
          shellcheck.args = vscode_settings["shellcheck.customArgs"]
        end
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end
  })
}
