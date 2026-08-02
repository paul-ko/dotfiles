local groups = require("keymap_groups")

return {
  {
    "nvim-mini/mini.nvim",
    version = "*", -- Stable branch
    config = function()
      local bufremove = require("mini.bufremove")
      bufremove.setup()
      vim.keymap.set("n", groups.buffers .. "c", bufremove.delete, { desc = "close current buffer" })
    end,
  },
}
