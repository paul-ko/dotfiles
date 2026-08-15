-- File categories used to pre-filter find/grep/word pickers.  These are based on
-- codebases that this config is active in, and will need to be updated over time.
local utils = require("utils")

local M = {}

M.categories = {
  { letter = "C", label = "config", globs = { "*.*config", "*.ini" } },
  { letter = "d", label = "docs", globs = { "*.md", "*.txt" } },
  { letter = "s", label = "structured", globs = { "*.csv", "*.json", "*.toml", "*.yaml" } },
  { letter = "u", label = "other", globs = { "LICENSE", "*.lock" } },
}

-- "code" is everything that doesn't match a known category, so its filter is
-- the exclusion of every category's globs combined.
function M.code_exclude_globs()
  local globs = {}
  for _, category in ipairs(M.categories) do
    globs = utils.combine_lists(globs, category.globs)
  end
  return globs
end

-- rg whitelist args (`--glob X --glob Y ...`) for a category's globs.
function M.include_args(globs)
  local args = {}
  for _, glob in ipairs(globs) do
    vim.list_extend(args, { "--glob", glob })
  end
  return args
end

-- `rg --files` exits 1 (not 0) when a whitelist glob matches nothing (e.g.
-- category `u` in a repo with no LICENSE/lockfile). snacks.nvim's files picker
-- always pops an interactive error notification on a nonzero exit and gives no
-- way to suppress it (unlike its grep picker), so check ahead of time whether
-- any file would match before opening a files picker for a whitelist category.
function M.any_files(globs)
  local args = { "rg", "--files", "--hidden", "-g", "!.git" }
  vim.list_extend(args, M.include_args(globs))
  local result = vim.system(args, { text = true }):wait()
  return result.code == 0
end

return M
