-- https://github.com/mfussenegger/nvim-lint
return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost", "BufReadPost", "InsertLeave" },
  config = function()
    require("lint").linters_by_ft = {
      lua = { "selene" },
      -- To install?
      -- markdown = { "markdownlint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("try lint", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
