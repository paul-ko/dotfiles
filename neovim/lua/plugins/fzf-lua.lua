-- https://github.com/ibhagwan/fzf-lua/blob/main/README.md
local git_pref = "<leader>g"
local search_pref = "<leader>s"
local mem_pref = "<leader><leader>"
local function excmd(cmd)
  return "<cmd>" .. cmd .. "<cr>"
end
local function exlua(lua)
  return excmd("lua " .. lua)
end
local function exfzf(call)
  return exlua("require('fzf-lua')." .. call)
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
      { search_pref .. "f", exfzf("files()"), desc = "fuzzy-find project files" },
      { mem_pref .. "f", exfzf("files()"), desc = "fuzzy-find project files" },
      { search_pref .. "g", exfzf("live_grep_native()"), desc = "live-grep project files" },
      { mem_pref .. "g", exfzf("live_grep_native()"), desc = "live-grep project files" },
      { search_pref .. "w", exfzf("grep_cword()"), desc = "grep current word within project" },
      { search_pref .. "W", exfzf("grep_cWORD()"), desc = "grep current WORD within project" },

      -- Git
      { git_pref .. "l", exfzf("git_commits()"), desc = "fuzzy-find log" },
      { git_pref .. "c", exfzf("git_bcommits()"), desc = "fuzzy-find commits (buffer)" },
    },
  },
}
