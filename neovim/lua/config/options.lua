-- Core Neovim behavior configuration that doesn't depend on any plugin

-- Mapleaders
vim.g.mapleader=","
vim.g.maplocalleader = "\\"

-- Tabs and spaces
vim.opt.tabstop=4           -- number of visual spaces per TAB
vim.opt.softtabstop=4       -- number of spaces in tab when editing
vim.opt.shiftwidth=4        -- use 4 spaces when indenting
vim.opt.expandtab=true      -- tabs are spaces

-- UI config
vim.opt.number=true
vim.opt.showcmd=true             -- show command in bottom bar
vim.opt.showmatch=true           -- highlight matching [{()}]

-- Searching
vim.opt.ignorecase=true     -- required for smartcase
vim.opt.smartcase=true

-- Folding
vim.opt.foldenable=true                     -- enable folding
vim.opt.foldlevelstart=100                  -- open most folds by default
vim.opt.foldmethod="indent"                 -- fold based on indent level

-- Other
vim.opt.colorcolumn="89"    -- visual ruler based on black settings

-- Filetypes
vim.filetype.add({
  extension = {
    -- Enables syntax highlighting in .gitconfig files
    gitconfig = "gitconfig",
  },
})

-- Directory tree; stay out of the way of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
