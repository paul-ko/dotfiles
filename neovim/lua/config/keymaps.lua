-- Leader shortcuts
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set(
    "n",
    "<leader><space>",
    "<cmd>noh<cr>",
    { desc = "Clear search highlighting" }
)

-- Folding
vim.keymap.set("n", "<space>", "za")        -- use space for folds

-- Motion
vim.keymap.set({"n", "v"}, "j", "gj")        -- move by visual line
vim.keymap.set({"n", "v"}, "k", "gk")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
