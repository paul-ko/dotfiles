local keys = require("keys")
local utils = require("utils")
local keymap_groups = require("keymap_groups")

-- Leader shortcuts
vim.keymap.set("i", "jk", keys.escape)
vim.keymap.set("n", keys.leader .. keys.space, utils.excmd("noh"), { desc = "Clear search highlighting" })

-- Folding
vim.keymap.set("n", keys.space, "za") -- use space for folds

-- Motion
vim.keymap.set({ "n", "v" }, "j", "gj") -- move by visual line
vim.keymap.set({ "n", "v" }, "k", "gk")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")

-- Diagnostic navigation — works for any diagnostic source (LSP, nvim-lint, etc.)
-- so these are global, not gated behind LspAttach.
vim.keymap.set("n", keymap_groups.diagnostics .. "l", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", keymap_groups.diagnostics .. "a", vim.diagnostic.setqflist, { desc = "All diagnostics (quickfix)" })
