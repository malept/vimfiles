-- Map Leader + character to reformatting executable
local function map_reformatter(character, bin_name, rest_of_cmd)
  if vim.fn.executable(bin_name) == 1 then
    vim.keymap.set('', string.format('<Leader>%s', character), string.format('!%s %s<CR>', bin_name, rest_of_cmd))
  end
end

-- HTML
map_reformatter('h', 'xmllint', '--format --html -')

-- JSON
-- Format in visual mode
-- See: http://blog.realnitro.be/2010/12/20/format-json-in-vim-using-pythons-jsontool-module/
map_reformatter('j', 'python3', '-m json.tool')

-- XML
map_reformatter('x', 'xmllint', '--format -')
