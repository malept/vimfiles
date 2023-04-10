local setup = function()
  require('mini.align').setup()
  require('mini.trailspace').setup()
end

return {
  {'echasnovski/mini.nvim', config = setup},
}
