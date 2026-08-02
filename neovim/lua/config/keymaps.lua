local keys = require("keys")
local utils = require("utils")
local keymap_groups = require("keymap_groups")

-- Leader shortcuts
vim.keymap.set("i", "jk", keys.escape)
vim.keymap.set("n", keys.leader .. keys.space, utils.excmd("noh"), { desc = "Clear search highlighting" })

-- Folding
vim.keymap.set("n", keys.space, "za") -- use space for folds
vim.keymap.set(
  "n",
  keymap_groups.toggle .. "c",
  require("comment_fold").toggle,
  { desc = "Toggle comment-only line folding" }
)

-- Motion
vim.keymap.set({ "n", "v" }, "j", "gj") -- move by visual line
vim.keymap.set({ "n", "v" }, "k", "gk")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")

-- Diagnostic navigation — works for any diagnostic source (LSP, nvim-lint, etc.)
-- so these are global, not gated behind LspAttach.
-- No dedicated top-level group; `d` now means "delete files/directories".
-- Line diagnostics is the one actually used day-to-day, so it lives in muscle memory.
vim.keymap.set("n", keymap_groups.memory .. "d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", keymap_groups.memory .. "D", vim.diagnostic.setqflist, { desc = "All diagnostics (quickfix)" })

-- Buffer navigation and management
vim.keymap.set("n", keymap_groups.buffers .. "b", utils.excmd("b#"), { desc = "back to prev buffer (b#, not stack)" })

-- Persistence
vim.keymap.set("n", keymap_groups.persistence .. "s", function()
  require("persistence").load()
end, { desc = "Load session for cwd" })

vim.keymap.set("n", keymap_groups.persistence .. "S", function()
  require("persistence").select()
end, { desc = "Select and load a session" })

vim.keymap.set("n", keymap_groups.persistence .. "l", function()
  require("persistence").load({ last = true })
end, { desc = "Load last session" })

vim.keymap.set("n", keymap_groups.persistence .. "d", function()
  require("persistence").stop()
end, { desc = "Stop persistence (don't save on exit)" })
