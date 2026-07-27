-- LSP setup

vim.lsp.enable({ "pyright" })

vim.diagnostic.config({
  float = {
    -- border need for legibility
    border = "rounded",
  },
  jump = {
    -- Open diagnostics in floating window on jump
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = "cursor",
        focus = false,
      })
    end,
  },
})
