-- Ripgrep support in FzfLua
local M = {}

M.default_opts = "--color=never --column --line-number --no-heading --smart-case --max-columns=4096 -e"

-- Tables of filetype categories for use in --types and --types-not
-- Incomplete; based on what I run into.
local config_types = { "config", "gradle", "toml", "yaml" }
local data_types = { "csv", "json", "jsonl", "lock", "log", "xml" } -- lock might ultimately belong in a new category
local doc_types = { "markdown", "readme", "txt" }

-- Candidate for promotion to a more generic module, but only needed here now.
local function build_repeated_cli_arg(val_table, arg)
  local safe_arg = " " .. arg .. " "
  local out = safe_arg
  out = out .. table.concat(val_table, safe_arg)
  return out
end

local rg_no_config = build_repeated_cli_arg(config_types, "--type-not")
local rg_no_data = build_repeated_cli_arg(data_types, "--type-not")
local rg_no_docs = build_repeated_cli_arg(doc_types, "--type-not")

-- Instead of opting into code, opt out of regularly encountered non-code.
M.rg_code = rg_no_config .. " " .. rg_no_data .. " " .. rg_no_docs .. " " .. M.default_opts

return M
