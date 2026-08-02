-- https://github.com/folke/which-key.nvim/blob/main/README.md
local groups = require("keymap_groups")

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        presets = {
          -- shows the built-in <C-w> window commands (split, close, nav, ...)
          -- when the prefix is pressed and held briefly
          windows = true,
        },
      },
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
        { groups.memory, group = "muscle memory" },
        { groups.buffers, group = "buffer" },
        { groups.git, group = "git" },
        { groups.search, group = "search" },
        { groups.find, group = "find" },
        -- groups.create, groups.delete: not registered yet, no keymaps under them
      })
    end,
  },
}
