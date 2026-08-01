-- https://github.com/folke/which-key.nvim/blob/main/README.md
local keymap_groups = require("keymap_groups")

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
        { keymap_groups.memory, group = "muscle memory" },
        { keymap_groups.buffer, group = "buffer" },
        { keymap_groups.diagnostics, group = "diagnostics" },
        { keymap_groups.files, group = "files" },
        { keymap_groups.git, group = "git" },
        { keymap_groups.search, group = "search" },
      })
    end,
  },
}
