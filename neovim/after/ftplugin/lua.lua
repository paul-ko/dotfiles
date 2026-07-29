-- bo sets buffer-specific configs - here we want to override for lua buffers only
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.opt_local.formatoptions:remove({ "r", "o" })
vim.opt_local.colorcolumn = "121"
