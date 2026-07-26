-- Visual line selection
vim.api.nvim_create_autocmd("InsertEnter", { command = "set cul" })
vim.api.nvim_create_autocmd("InsertLeave", { command = "set nocul" })
