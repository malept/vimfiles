-- go.nvim
if vim.fn.executable('gopls') == 1 then
  require('go').setup({
    goimport = 'gopls', -- if set to 'gopls' will use golsp format
    gofmt = 'gopls', -- if set to gopls will use golsp format
    lsp_cfg = {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    },
  })
  -- Format + Import on save
  vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
end
