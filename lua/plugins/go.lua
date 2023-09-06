local plugin = require('plugin_util')

local setup = function()
  if vim.fn.executable('gopls') == 1 then
    require('go').setup({
      goimport = 'gopls', -- if set to 'gopls' will use golsp format
      gofmt = 'gopls', -- if set to gopls will use golsp format
      lsp_cfg = false, -- let lspcompletion.lua handle LSP
    })
    -- Import on save
    local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function() require('go.format').goimport() end,
      group = format_sync_grp,
    })
  end
end

return {
  plugin.not_vscode_plugin({'ray-x/go.nvim',
    event = 'CmdlineEnter',
    ft = {'go', 'gomod'},
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
      'ray-x/guihua.lua',
    },
    config = setup,
  }),
}
