-- Visual line selection
vim.api.nvim_create_autocmd("InsertEnter", { command = "set cul" })
vim.api.nvim_create_autocmd("InsertLeave", { command = "set nocul" })

-- Diagnostic navigation — works for any diagnostic source (LSP, nvim-lint, etc.)
-- so these are global, not gated behind LspAttach.
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>D", vim.diagnostic.setqflist, { desc = "All diagnostics (quickfix)" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gr", vim.lsp.buf.references, "References")
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  end,
})
