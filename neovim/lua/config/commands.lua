-- User-defined Ex commands and abbreviations

-- User-defined commands must start with an upper-case letter
-- Commands can call locally defined functions

--[[
local f = function(arg) print(arg) end
vim.api.nvim_create_user_command("Me", function(opts) f(opts.fargs[1]) end, { nargs = "+" })
`:Me x` will print x
]]

-- Abbreviations
vim.cmd("cnoreabbrev vsb vert sb")
vim.cmd("cnoreabbrev halp help helphelp")
