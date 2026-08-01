-- https://github.com/ibhagwan/fzf-lua/blob/main/README.md
return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {},
    ---@diagnostic enable: missing-fields
    keys = {
      { "<leader>sf", "<cmd>lua require('fzf-lua').files()<cr>", desc = "fuzzy-find project files" },
      { "<leader><leader>f", "<cmd>lua require('fzf-lua').files()<cr>", desc = "fuzzy-find project files" },
      { "<leader>sg", "<cmd>lua require('fzf-lua').live_grep_native()<cr>", desc = "live-grep project files" },
      { "<leader><leader>g", "<cmd>lua require('fzf-lua').live_grep_native()<cr>", desc = "live-grep project files" },
      { "<leader>sw", "<cmd>lua require('fzf-lua').grep_cword()<cr>", desc = "grep current word within project" },
      { "<leader>sW", "<cmd>lua require('fzf-lua').grep_cWORD()<cr>", desc = "grep current WORD within project" },
    },
  },
}
