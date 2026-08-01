local keys = require("keys")
local M = {}

M.memory = keys.leader .. keys.leader

M.git = keys.leader .. "g"
M.search = keys.leader .. "s"
M.find = keys.leader .. "f"
M.create = keys.leader .. "c"
M.delete = keys.leader .. "d"
M.buffers = keys.leader .. "b"

return M
