-- https://github.com/lewis6991/gitsigns.nvim/blob/main/README.md
local groups = require("keymap_groups")

return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    -- lazy.nvim only auto-forwards `opts` into require("gitsigns").setup(opts);
    -- on_attach has to live inside it.
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", groups.git .. "b", gitsigns.blame)
        map("n", groups.git .. "d", gitsigns.diffthis)
      end,
    },
  },
}
