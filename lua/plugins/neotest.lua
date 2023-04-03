require('neotest').setup({
  adapters = {
    require('neotest-go'),
    require('neotest-jest'),
    require('neotest-rspec'),
    require('neotest-rust'),
    require('neotest-vim-test')({ ignore_filetypes = { "go", "ruby", "rust" } })
  }
})

-- Run nearest test
vim.keymap.set('n', '<Leader>t', function() require("neotest").run.run() end, { silent = true })
-- Run current file
vim.keymap.set('n', '<Leader>T', function() require("neotest").run.run(vim.fn.expand("%")) end, { silent = true })
-- Debug nearest test
vim.keymap.set('n', '<Leader>dt', function() require("neotest").run.run({strategy = "dap"}) end, { silent = true })
