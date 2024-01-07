local M = {}

local function prequire(m_name)
  local ok, res = pcall(require, m_name)
  if not ok then
    return nil, res
  end
  return res
end

local jsonc, jsonc_err = prequire("luasnip.util.jsonc")

local loaded_settings = {}

M.expand = function(data, base_dir)
  base_dir = base_dir or vim.fn.getcwd()
  return string.gsub(data, "${workspaceFolder}", base_dir)
end

M.load = function(base_dir)
  if jsonc == nil then
    print("Loading VSCode settings requires luasnip: " .. jsonc_err)
    return nil
  end

  base_dir = base_dir or vim.fn.getcwd()

  if loaded_settings[base_dir] == nil then
    local path = base_dir .. "/.vscode/settings.json"
    local file = io.open(path, "r")
    if not file then
      return nil
    end
    local contents = file:read("*all")
    loaded_settings[base_dir] = jsonc.decode(contents)
    file:close()
  end

  return loaded_settings[base_dir]
end

return M
