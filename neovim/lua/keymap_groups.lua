local keys = require("keys")
local M = {}

M.memory = keys.leader .. keys.leader

M.git = keys.leader .. "g"
M.search = keys.leader .. "s"
M.find = keys.leader .. "f"
M.code = keys.leader .. "c"
M.delete = keys.leader .. "d"
M.buffers = keys.leader .. "b"
M.persistence = keys.leader .. "p"
M.toggle = keys.leader .. "t"

return M
