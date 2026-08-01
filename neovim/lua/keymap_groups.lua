local M = {}

local leader = "<leader>"

M.buffer = leader .. "b"
M.diagnostics = leader .. "d"
M.files = leader .. "f"
M.git = leader .. "g"
M.memory = leader .. leader
M.search = leader .. "s"

return M
