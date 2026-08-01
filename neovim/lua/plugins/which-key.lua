-- https://github.com/folke/which-key.nvim/blob/main/README.md
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer-local keymaps (which-key)",
      },
    },
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<leader><leader>", group = "muscle memory" },
        { "<leader>b", group = "buffer" },
        { "<leader>d", group = "diagnostics" },
        { "<leader>f", group = "files" },
        { "<leader>g", group = "git" },
        { "<leader>s", group = "search" },
      })
    end,
  },
}
