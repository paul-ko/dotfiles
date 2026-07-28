-- If a desire arises to customize or extend this, strongly consider checking
-- conform.nvim as potentially more standard current plugin for the same purpose.
return {
  {
    "sbdchd/neoformat",
    config = function()
      vim.g.shfmt_opt = "-ci"
      local group = vim.api.nvim_create_augroup("fmt", { clear = true })
      -- Format on save for shell files.
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = "*.sh",
        group = group,
        command = "undojoin | Neoformat",
      })
    end,
  },
}
