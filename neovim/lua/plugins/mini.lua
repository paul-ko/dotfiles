return {
  {
    "nvim-mini/mini.nvim",
    version = "*", -- Stable branch
    config = function()
      local bufremove = require("mini.bufremove")
      bufremove.setup()
      vim.keymap.set("n", "<leader>bd", bufremove.delete)
    end,
  },
}
