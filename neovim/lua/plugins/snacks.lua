local groups = require("keymap_groups")

return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {},
      explorer = {},
    },
    keys = {
      -- Memory keymaps - what I use most frequently.
      {
        groups.memory .. "f",
        function()
          Snacks.picker.files({ frecency = true, hidden = true })
        end,
        desc = "Search files all",
      },
      {
        groups.memory .. "g",
        function()
          Snacks.picker.grep()
        end,
        desc = "Live grep",
      },

      -- Find files/directories
      {
        groups.find .. "a",
        function()
          Snacks.picker.files({ frecency = true })
        end,
        desc = "find files all",
      },

      -- Git
      {
        groups.git .. "l",
        function()
          Snacks.picker.git_log()
        end,
        desc = "git log",
      },
      {
        groups.git .. "d",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "git diff",
      },

      -- Search (content)
      {
        groups.search .. "a",
        function()
          Snacks.picker.grep()
        end,
        desc = "search content all",
      },

      -- Word (cursor-based)
      {
        groups.search .. "w",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "grep current word within project",
      },
    },
  },
}
