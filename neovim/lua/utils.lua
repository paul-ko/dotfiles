-- https://neovim.io/doc/user/lua-guide/#_lua-modules
-- General utilities useful across multiple files
-- Break up if it grows significantly
local M = {}

-- This will likely run into issues if `cmd` needs to be passed dynamic text that needs escapes to be lua-safe.
function M.excmd(cmd)
  return "<cmd>" .. cmd .. "<cr>"
end
function M.exlua(lua)
  return M.excmd("lua " .. lua)
end

return M
