local keys = require("keys")
local M = {}

M.buffer = keys.leader .. "b"
M.diagnostics = keys.leader .. "d"
M.files = keys.leader .. "f"
M.git = keys.leader .. "g"
M.memory = keys.leader .. keys.leader
M.search = keys.leader .. "s"

return M
