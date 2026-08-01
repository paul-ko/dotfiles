-- https://github.com/ibhagwan/fzf-lua/blob/main/README.md
local utils = require("utils")
local keymap_groups = require("keymap_groups")
local function exfzf(call)
  return utils.exlua("require('fzf-lua')." .. call)
end

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
      -- Core searches
      { keymap_groups.search .. "f", exfzf("files()"), desc = "fuzzy-find project files" },
      { keymap_groups.memory .. "f", exfzf("files()"), desc = "fuzzy-find project files" },
      { keymap_groups.search .. "g", exfzf("live_grep_native()"), desc = "live-grep project files" },
      { keymap_groups.memory .. "g", exfzf("live_grep_native()"), desc = "live-grep project files" },
      { keymap_groups.search .. "w", exfzf("grep_cword()"), desc = "grep current word within project" },
      { keymap_groups.search .. "W", exfzf("grep_cWORD()"), desc = "grep current WORD within project" },

      -- Git
      { keymap_groups.git .. "l", exfzf("git_commits()"), desc = "fuzzy-find log" },
      { keymap_groups.git .. "c", exfzf("git_bcommits()"), desc = "fuzzy-find commits (buffer)" },
    },
  },
}
