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
      config = function()
          vim.keymap.set(
              "n",
              "<leader>f",  -- project files
              "<cmd>lua require('fzf-lua').files()<cr>"
          )
          vim.keymap.set(
              "n",
              "<leader>g",  -- project text
              "<cmd>lua require('fzf-lua').live_grep_native()<cr>"
          )
          vim.keymap.set(
              "n",
              "<leader>r",  -- project text for selected word
              "<cmd>lua require('fzf-lua').grep_cword()<cr>"
          )
          vim.keymap.set(
              "n",
              "<leader>R",  -- project text for selected WORD
              "<cmd>lua require('fzf-lua').grep_cWORD()<cr>"
          )
      end
    }
}
