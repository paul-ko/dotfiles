-- https://neovim.io/doc/user/lua-guide/#_lua-modules
-- General utilities useful across multiple files
-- Break up if it grows significantly
local M = {}

function M.excmd(cmd)
  return "<cmd>" .. cmd .. "<cr>"
end
function M.exlua(lua)
  return M.excmd("lua " .. lua)
end

return M
