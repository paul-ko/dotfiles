--[[
See
  - https://neovim.io/doc/user/lua-guide/
  - https://github.com/jdhao/nvim-config
  - https://lazy.folke.io/
]]

require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.autocmds")

-- Dracula requires a plugin; investigate after Lazy.nvim
-- vim.cmd.colorscheme("dracula")
