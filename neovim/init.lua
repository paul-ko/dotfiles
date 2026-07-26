-- See
-- - https://neovim.io/doc/user/lua-guide/
-- - https://github.com/jdhao/nvim-config

vim.filetype.add({
  extension = {
    gitconfig = "gitconfig",
  },
})

-- Dracula requires a plugin; investigate after Lazy.nvim
-- vim.cmd.colorscheme("dracula")

-- Tabs and spaces
vim.opt.tabstop=4           -- number of visual spaces per TAB
vim.opt.softtabstop=4       -- number of spaces in tab when editing
vim.opt.shiftwidth=4        -- use 4 spaces when indenting
vim.opt.expandtab=true      -- tabs are spaces

-- UI config
vim.opt.number=true              -- show line numbers
vim.opt.showcmd=true             -- show command in bottom bar
vim.opt.showmatch=true           -- highlight matching [{()}] 

-- Leader shortcuts
vim.g.mapleader=","                  -- leader is comma
vim.keymap.set("i", "jk", "<ESC>")   -- map jk to escape in insert mode

-- Searching
vim.opt.ignorecase=true     -- required for smartcase
vim.opt.smartcase=true
vim.keymap.set("n", "<leader><space>", "<cmd>noh<cr>", { desc = "Clear search highlighting" })

-- Folding
vim.opt.foldenable=true                     -- enable folding
vim.opt.foldlevelstart=100                  -- open most folds by default
vim.keymap.set("n", "<space>", "za")        -- use space for folds
vim.opt.foldmethod="indent"                 -- fold based on indent level

-- Motion
vim.keymap.set({"n", "v"}, "j", "gj")        -- move by visual line 
vim.keymap.set({"n", "v"}, "k", "gk")        -- move by visual line 
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")   -- no ^w prefix for split navigation
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")   -- no ^w prefix for split navigation
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")   -- no ^w prefix for split navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")   -- no ^w prefix for split navigation

-- Visual line selection
vim.api.nvim_create_autocmd("InsertEnter", { command = "set cul" })
vim.api.nvim_create_autocmd("InsertLeave", { command = "set nocul" })

-- Other
vim.opt.colorcolumn="89"    -- visual ruler based on black settings
